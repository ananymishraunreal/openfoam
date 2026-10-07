#!/bin/bash
# run_solo.sh — SOLO (single-machine, serial, 1 rank) baseline for test1 comparison.
# Runs on ONE machine (5-166), no MPI, no SLURM: blockMesh + foamRun.
# Usage: ./run_solo.sh   (run as amp_user from any node with OpenFOAM 12)
set -eo pipefail

set +e
source /opt/openfoam12/etc/bashrc
set -e

CASE_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$CASE_DIR"
echo "=== SOLO serial run: $CASE_DIR on $(hostname) ==="

rm -rf log.blockMesh log.foamRun 100 200 296 2>/dev/null || true

blockMesh 2>&1 | tee log.blockMesh | tail -n 4

START=$(date +%s)
echo "SOLO_START_EPOCH=$START ($(date))"
foamRun 2>&1 | tee log.foamRun | tail -n 2
END=$(date +%s)
echo "SOLO_END_EPOCH=$END ($(date))"
echo "SOLO_WALL_SECONDS=$((END-START))"
