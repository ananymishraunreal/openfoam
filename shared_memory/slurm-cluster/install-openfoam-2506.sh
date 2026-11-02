#!/bin/bash
# install-openfoam-2506.sh — user-level build of OpenFOAM v2506 (ESI) —
# the version laserbeamFoam's CI pins. Installs into ~/apps/OpenFOAM.
# Requires: no sudo. Build time ~30-60 min on 16 cores.

set -eo pipefail

VER=v2506
ROOT=$HOME/apps/OpenFOAM
SRC=$ROOT/src
DL=$SRC/downloads
mkdir -p "$ROOT" "$DL"

# Fetch
for f in "OpenFOAM-$VER.tgz" "ThirdParty-$VER.tgz"; do
    if [ ! -f "$DL/$f" ]; then
        echo ">> fetching $f"
        curl -fsSL -o "$DL/$f" "https://sourceforge.net/projects/openfoam/files/v2506/$f/download" || \
        curl -fsSL -o "$DL/$f" "https://www.openfoam.com/download/source/$f"
    fi
done

# Extract to standard ESI layout: $FOAM_INST/{OpenFOAM,ThirdParty}-$VER
cd "$ROOT"
[ -d "OpenFOAM-$VER" ]   || tar -xzf "$DL/OpenFOAM-$VER.tgz"
[ -d "ThirdParty-$VER" ] || tar -xzf "$DL/ThirdParty-$VER.tgz"

# Build
export FOAM_INST="$ROOT"
set +e
source "$ROOT/OpenFOAM-$VER/etc/bashrc"
set -e
: "${WM_PROJECT_DIR:?}"

# gcc 16 on Omarchy is newer than upstream testing; soften errors so the
# many-old-constructs compile. Add real fixes here only if the build fails.
export WM_CXXFLAGS="${WM_CXXFLAGS:-} -fpermissive -Wno-error=return-type -Wno-error=template-body -Wno-error=volatile -Wno-error=restrict"
export WM_CFLAGS="${WM_CFLAGS:-} -Wno-error=return-type -Wno-error=restrict"

# ThirdParty: build MPI fallback / scotch etc.; tolerate optional failures
( cd "$WM_THIRD_PARTY_DIR" && ./Allwmake 2>&1 | tee log.ThirdParty.Allwmake ) || \
    echo "WARNING: ThirdParty had partial failures — continuing"

( cd "$WM_PROJECT_DIR" && ./Allwmake -j "$(nproc)" 2>&1 | tee log.OpenFOAM.Allwmake ) || \
    { echo "OpenFOAM core build FAILED — see log.OpenFOAM.Allwmake" >&2; exit 1; }

# post-build sanity
echo "install-openfoam-2506.sh: OK"
ls "$FOAM_USER_APPBIN" 2>/dev/null | head -5 || true
command -v simpleFoam || echo "(simpleFoam not found — check log.OpenFOAM.Allwmake)"
