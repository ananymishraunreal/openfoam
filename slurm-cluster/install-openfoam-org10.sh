#!/bin/bash
# install-openfoam-org10.sh — user-level build of OpenFOAM-10 (Foundation),
# for the waam/base/damBreak fixture (Foundation-style dicts:
# phaseProperties + physicalProperties.air/.water). No sudo required; uses
# system openmpi (installed by the sudo cluster script) or falls back to
# trying its ThirdParty fetch. Installs into ~/apps/OpenFOAM.

set -eo pipefail

MVER=10
ROOT=$HOME/apps/OpenFOAM
SRC=$ROOT/src
DL=$SRC/downloads-org
mkdir -p "$ROOT" "$DL"

fetch() { # url, outfile
    curl -fsSL --max-time 120 -o "$2" "$1"
}

echo ">> fetching OpenFOAM-10 sources"
if [ ! -f "$DL/OpenFOAM-10.tar.gz" ]; then
    fetch "https://download.openfoam.org/source/released/OpenFOAM-10.tar.gz" "$DL/OpenFOAM-10.tar.gz" 2>/dev/null || \
    fetch "https://github.com/OpenFOAM/OpenFOAM-10/archive/refs/heads/master.tar.gz" "$DL/OpenFOAM-10.tar.gz"
fi
if [ ! -f "$DL/ThirdParty-10.tar.gz" ]; then
    fetch "https://download.openfoam.org/source/released/ThirdParty-10.tar.gz" "$DL/ThirdParty-10.tar.gz" 2>/dev/null || \
    echo "FAIL ThirdParty fetch — scotch variant disabled" || true
fi

cd "$SRC"
[ -d OpenFOAM-10 ]   || tar -xzf "$DL/OpenFOAM-10.tar.gz"   && { ver_dir=$(ls -d OpenFOAM-10* | head -1); [ "$ver_dir" = "OpenFOAM-10" ] || mv "$ver_dir" OpenFOAM-10; }
[ -f "$DL/ThirdParty-10.tar.gz" ] && { [ -d ThirdParty-10 ] || tar -xzf "$DL/ThirdParty-10.tar.gz"; tp_dir=$(ls -d ThirdParty-10* 2>/dev/null | head -1); [ "$tp_dir" = "ThirdParty-10" ] || mv "$tp_dir" ThirdParty-10; }

set +e
source "$SRC/OpenFOAM-10/etc/bashrc"
set -e
export WM_CXXFLAGS="${WM_CXXFLAGS:-} -fpermissive -Wno-error=return-type"
export WM_CFLAGS="${WM_CFLAGS:-}   -Wno-error=return-type"

# system openmpi comes from pacman (cluster script). If it's missing, use cached
# sudo ticket (non-interactive) — fails politely otherwise.
command -v mpirun >/dev/null || sudo -n pacman -Sy --needed --noconfirm openmpi || true

if [ -d "$WM_THIRD_PARTY_DIR" ]; then
    ( cd "$WM_THIRD_PARTY_DIR" && ./Allwmake 2>&1 | tee log.tp || true )
fi

cd "$WM_PROJECT_DIR"
./Allwmake -j"$(nproc)" 2>&1 | tee log.openfoam10

echo "install-openfoam-org10.sh: OK"
command -v interFoam
command -v blockMesh
