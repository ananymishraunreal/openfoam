#!/bin/bash
# build-am-solvers.sh — build the two custom AM solvers against OpenFOAM v2506.
# Requires install-openfoam-2506.sh to have completed.

set -eo pipefail

VER=v2506
ROOT=$HOME/apps/OpenFOAM/OpenFOAM-$VER
set +e
source "$ROOT/etc/bashrc"
set -e
: "${WM_PROJECT_DIR:?}"
export WM_CXXFLAGS="${WM_CXXFLAGS:-} -fpermissive -Wno-error=return-type"
mkdir -p "$HOME/apps/solvers"
cd "$HOME/apps/solvers"

# --- laserbeamFoam (LPBF + WAAM reference) -------------------------------------
if [ ! -d laserbeamFoam ]; then
    git clone https://github.com/laserbeamfoam/LaserbeamFoam laserbeamFoam
fi
cd laserbeamFoam
git fetch origin OpenFoam_com_main --depth 1 2>/dev/null || true
git checkout -q OpenFoam_com_main
PIN=3827840e600b6c15fe7eeb19d437c4f2a33b4c4f
if [ "$(git rev-parse HEAD)" != "$PIN" ]; then
    git fetch origin "$PIN" --depth 1 2>/dev/null || true
    git checkout -q "$PIN"
fi
./Allwmake -j"$(nproc)" 2>&1 | tee log.build
echo "laserbeamFoam build done; binaries present in FOAM_USER_APPBIN ($FOAM_USER_APPBIN):"
ls -1 "$FOAM_USER_APPBIN" | head -10

# --- laserWireDEDFoam (WLAM) ---------------------------------------------------
cd "$HOME/apps/solvers"
if [ ! -d laser-wire-ded-project ]; then
    git clone https://github.com/dukyong414/laser-wire-ded-project laser-wire-ded-project
fi
cd laser-wire-ded-project
git fetch origin main --depth 1 2>/dev/null || true
git checkout -q 9fc736e99d61852a306b3f8e67022d368fc669dd
cd solver/laserWireDEDFoam
wmake 2>&1 | tee log.build || { echo "laserWireDEDFoam build failed against $VER — may need v2406 build as upstream README says" >&2; exit 1; }
echo "laserWireDEDFoam: binary:" $(command -v laserWireDEDFoam)
echo "build-am-solvers.sh: OK"
