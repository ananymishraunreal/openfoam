#!/bin/bash
# run_solo.sh — HEAVY serial baseline (1 rank, no MPI, no SLURM).
# Case: heavySimple = pitzDailySteady geometry, ~782k cells (64x base 12k).
# Usage: ./run_solo.sh   (run as amp_user, OpenFOAM 12)
# Expect: several minutes (vs ~5 s for the 12k base case).
set -eo pipefail

set +e
source /opt/openfoam12/etc/bashrc
set -e

CASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$CASE_DIR"
echo "=== HEAVY SOLO serial run: $CASE_DIR on $(hostname) ==="

rm -rf log.blockMesh log.foamRun 500 1000 1500 2000 postProcessing 2>/dev/null || true

blockMesh 2>&1 | tee log.blockMesh | tail -n 4
checkMesh 2>&1 | tail -n 15 || true

START=$(date +%s)
echo "SOLO_START_EPOCH=$START ($(date))"
foamRun 2>&1 | tee log.foamRun | tail -n 2
END=$(date +%s)
echo "SOLO_END_EPOCH=$END ($(date))"
echo "SOLO_WALL_SECONDS=$((END-START))"
