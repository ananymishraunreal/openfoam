#!/bin/bash
# run_solo.sh — HEAVY serial baseline (1 rank, no MPI, no SLURM).
# Case: heavyBuoyant = buoyantCavity geometry, ~630k cells (8x base 78,750).
# Usage: ./run_solo.sh   (run as amp_user, OpenFOAM 12)
set -eo pipefail

set +e
source /opt/openfoam12/etc/bashrc
set -e

CASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$CASE_DIR"
echo "=== HEAVY SOLO serial run: $CASE_DIR on $(hostname) ==="

rm -rf log.blockMesh log.foamRun postProcessing 2>/dev/null || true

blockMesh 2>&1 | tee log.blockMesh | tail -n 4
checkMesh 2>&1 | tail -n 15 || true

START=$(date +%s)
echo "SOLO_START_EPOCH=$START ($(date))"
foamRun 2>&1 | tee log.foamRun | tail -n 2
END=$(date +%s)
echo "SOLO_END_EPOCH=$END ($(date))"
echo "SOLO_WALL_SECONDS=$((END-START))"
