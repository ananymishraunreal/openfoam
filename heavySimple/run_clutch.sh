#!/bin/bash
# run_clutch.sh — one-command heavySimple via foam-clutch.
# Chains validate -> submit -> watch, passing the job/slurm IDs automatically,
# and appends every run to a custom log file. No manual ID copy-paste.
#
# Usage:
#   ./run_clutch.sh                  # full run, blocks until DONE/FAILED
#   ./run_clutch.sh --submit-only     # submit + log IDs, return immediately
#   RUN_LOG=/path/to.log ./run_clutch.sh   # custom log location
set -eo pipefail

MANIFEST=/home/shared/openfoam/heavySimple/manifest.yaml
DB=/home/shared/openfoam/heavySimple/foam-clutch.db
RUN_LOG="${RUN_LOG:-/home/shared/openfoam/heavySimple/foam-clutch-runs.log}"
BACKEND="${BACKEND:-cli}"
CLUTCH=/home/shared/foam-clutch

SUBMIT_ONLY=0
if [ "${1:-}" = "--submit-only" ]; then SUBMIT_ONLY=1; fi

cd "$CLUTCH"

echo "--- validate ---"
go run ./cmd/foam-clutch validate -manifest "$MANIFEST" > /dev/null
echo "validate: OK"

echo "--- submit (backend=$BACKEND) ---"
OUT=$(go run ./cmd/foam-clutch submit -manifest "$MANIFEST" -db "$DB" -backend "$BACKEND")
ID=$(echo "$OUT" | python3 -c "import json,sys; print(json.load(sys.stdin)['ID'])")
SLURM=$(echo "$OUT" | python3 -c "import json,sys; print(json.load(sys.stdin)['SlurmID'])")
RUNPATH=$(echo "$OUT" | python3 -c "import json,sys; print(json.load(sys.stdin)['RunPath'])")
echo "$(date -Is) SUBMIT id=$ID slurm=$SLURM run=$RUNPATH" | tee -a "$RUN_LOG"
echo "$OUT" >> "$RUN_LOG"

echo "solver log: $RUNPATH/log.solver"
echo "slurm log:  $RUNPATH/slurm-$SLURM.out"
squeue -j "$SLURM" 2>/dev/null || true

if [ "$SUBMIT_ONLY" = "1" ]; then
  echo "submitted only. follow with:"
  echo "  tail -f $RUNPATH/slurm-$SLURM.out"
  echo "  go run ./cmd/foam-clutch watch -db $DB -id $ID -slurm $SLURM -backend $BACKEND"
  exit 0
fi

echo "--- watch (blocks until DONE/FAILED/CANCELLED) ---"
WATCH_OUT=$(go run ./cmd/foam-clutch watch -db "$DB" -id "$ID" -slurm "$SLURM" -backend "$BACKEND")
STATE=$(echo "$WATCH_OUT" | python3 -c "import json,sys; print(json.load(sys.stdin)['State'])")
echo "$(date -Is) FINAL  id=$ID slurm=$SLURM state=$STATE run=$RUNPATH" | tee -a "$RUN_LOG"
