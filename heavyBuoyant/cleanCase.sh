#!/bin/bash
# cleanCase.sh — basic OpenFOAM case cleaner for HPC runs.
# Resets the case to its initial (pre-mesh) state using OpenFOAM's
# foamCleanCase, plus removes this cluster's extra artefacts.
#
# Usage:
#   ./cleanCase.sh                 # cleans this case dir (heavyBuoyant)
#   ./cleanCase.sh -case <dir>     # cleans another case dir

set -eo pipefail

CASE_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ "${1:-}" = "-case" ] && [ -n "${2:-}" ]; then
  CASE_DIR="$2"
fi

# OpenFOAM env (guarded: foam bashrc can return non-zero in batch shells)
set +e
source /opt/openfoam12/etc/bashrc
set -e

echo "=== Cleaning case: $CASE_DIR ==="
cd "$CASE_DIR"

echo "--- before ---"
ls
echo "times before: $(foamListTimes 2>/dev/null | tr '\n' ' ')"

foamCleanCase -case "$CASE_DIR"

# HPC extras foamCleanCase does not cover
rm -f "$CASE_DIR"/slurm-*.out "$CASE_DIR"/slurm-*.err

echo "--- after ---"
ls
echo "times after: $(foamListTimes 2>/dev/null | tr '\n' ' ')"
echo "=== Clean done. Case is back to initial state (re-run with: sbatch run_openfoam.slurm) ==="
