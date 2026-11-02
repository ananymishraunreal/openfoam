#!/bin/bash
# run-fixture.sh — short scratch runs of the three AM fixtures.
# Purpose: produce the artifact set a normal run leaves behind
# (processor0..N, time dirs inside processors, log.* files) WITHOUT running
# full production cases, and WITHOUT touching the pinned raw fixture tree.
# Usage: bash run-fixture.sh <lpbf|wlam|waam>

set -eo pipefail
ROOT=/home/anany/shared_memory/run-scratch
mkdir -p "$ROOT"
cd "$ROOT"

CASE_NAME="$1"
SRC=;  DST=; ENV_SRC=; SOLVER=; NP=16

case "$CASE_NAME" in
  lpbf)  SRC=/home/anany/shared_memory/lpbf/case
         ENV_SRC=$HOME/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc
         SOLVER=laserbeamFoam ;;
  wlam)  SRC=/home/anany/shared_memory/wlam/case
         ENV_SRC=$HOME/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc
         SOLVER=laserWireDEDFoam ;;
  waam)  SRC=/home/anany/shared_memory/waam/base/damBreak
         ENV_SRC=$HOME/apps/OpenFOAM/src/OpenFOAM-10/etc/bashrc
         SOLVER=interFoam ;;
  *) echo "unknown fixture: $1"; exit 1 ;;
esac

DST=$ROOT/$CASE_NAME
rm -rf "$DST"; mkdir -p "$DST"
cp -r "$SRC"/. "$DST"/
cd "$DST"

# --- env ------------------------------------------------------------------
set +e
source "$ENV_SRC"
set -e

echo "== $CASE_NAME: env $SOLVER, np=$NP, endTime shortened for artifact-only run"

# --- per-case dict edits (scratch only) -------------------------------------
case "$CASE_NAME" in
  lpbf)  foamDictionary -entry endTime       -set 2e-7  system/controlDict > /dev/null
         foamDictionary -entry writeInterval -set 1e-7  system/controlDict > /dev/null ;;
  wlam)  foamDictionary -entry endTime       -set 5e-7  system/controlDict > /dev/null
         foamDictionary -entry writeInterval -set 2e-7  system/controlDict > /dev/null ;;
  waam)  foamDictionary -entry endTime       -set 0.05  system/controlDict > /dev/null
         foamDictionary -entry writeInterval -set 0.01 system/controlDict > /dev/null ;;
esac
foamDictionary -entry numberOfSubdomains -set "$NP"   system/decomposeParDict > /dev/null
foamDictionary -entry method             -set scotch system/decomposeParDict > /dev/null

# --- prep -------------------------------------------------------------------
case "$CASE_NAME" in
  lpbf)
      cp -r initial 0
      blockMesh                    > log.blockMesh 2>&1
      setSolidFraction -subDivisions 6 > log.setSolidFraction 2>&1
      transformPoints -rotate '((0 1 0) (0 0 1))' > log.transformPoints 2>&1
      ;;
  wlam)
      blockMesh > log.blockMesh 2>&1
      topoSet   > log.topoSet 2>&1
      createPatch -overwrite > log.createPatch 2>&1
      rm -rf 0 && mkdir 0 && cp 0.orig/* 0/
      for f in 0/*.orig; do mv "$f" "${f%.orig}"; done
      setFields > log.setFields 2>&1
      ;;
  waam)
      blockMesh > log.blockMesh 2>&1
      setFields > log.setFields 2>&1
      ;;
esac

# --- decompose --------------------------------------------------------------
decomposePar > log.decomposePar 2>&1
echo "$CASE_NAME: decomposePar -> $(find processor*/ -maxdepth 0 | wc -l) subdomain dirs"

# --- short parallel solve ---------------------------------------------------
export OMPI_MCA_rmaps_base_mapping_policy=:OVERSUBSCRIBE
mpirun -np "$NP" "$SOLVER" -parallel > "log.$SOLVER" 2>&1 || \
    { echo "$CASE_NAME: solver exited nonzero — artifacts up to last good time kept"; }

# --- artifact summary -------------------------------------------------------
NTIME=$(find processor0 -mindepth 1 -maxdepth 1 -type d ! -name '[[:digit:]]*' | wc -l)
TIMES=$(find processor0 -mindepth 1 -maxdepth 1 -type d -name '[[:digit:]]*' | sort | tr '\n' ' ')
echo "== $CASE_NAME ARTIFACTS: processorN=$(find processor*/ -maxdepth 0 | wc -l), time dirs in processor0: $TIMES, logs: $(ls log.* 2>/dev/null | tr '\n' ' ')"
