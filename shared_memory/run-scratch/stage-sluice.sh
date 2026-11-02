#!/bin/bash
# stage-sluice.sh — stage three Sluice pilot manifests with light case edits
# in scratch copies. Raw fixtures untouched; this script is rerun-safe.
set -eo pipefail
R=/home/anany/shared_memory/run-scratch/sluice
S=/home/anany/shared_memory
mkdir -p "$R"

prep_case () { # src dst
    rm -rf "$2/m"; mkdir -p "$2"
    cp -r "$1"/. "$2/m"
    if [ "$1" = "$S/lpbf/case" ]; then DE1=2e-7; WI=1e-7;
    elif [ "$1" = "$S/wlam/case" ]; then DE1=5e-7; WI=2e-7;
    else DE1=0.05; WI=0.01; fi
    cd "$2/m"
    sed -i -E "s|^[[:space:]]*endTime[[:space:]]+[^;]+;$|endTime       ${DE1};|" system/controlDict
    sed -i -E "s|^[[:space:]]*writeInterval[[:space:]]+[^;]+;$|writeInterval ${WI};|" system/controlDict
    sed -i -E "s|^[[:space:]]*numberOfSubdomains[[:space:]]+[^;]+;$|numberOfSubdomains 16;|" system/decomposeParDict
    sed -i -E "s|^[[:space:]]*method[[:space:]]+[^;]+;$|method       scotch;|" system/decomposeParDict
    cd - > /dev/null
}

# --- LPBF -------------------------------------------------------------------
prep_case "$S/lpbf/case" "$R/lpbf"
cat > "$R/lpbf/m/prep.sh" <<'EOF'
#!/bin/bash
set -e
cp -r initial 0
blockMesh
setSolidFraction -subDivisions 6
transformPoints -rotate '((0 1 0) (0 0 1))'
EOF
chmod +x "$R/lpbf/m/prep.sh"
cat > "$R/lpbf/manifest.yaml" <<'EOF'
apiVersion: sluice/v1alpha1
name: lpbf-artifact-run
case:
  path: ./m
mesh:
  strategy: custom
  commands: ["./prep.sh"]
resources:
  partition: all
  nodes: 1
  tasksPerNode: 16
  timeLimitMinutes: 30
solver:
  name: laserbeamFoam
runtime:
  foamBashrc: /home/anany/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc
EOF
mkdir -p "$R/lpbf"

# --- WLAM -------------------------------------------------------------------
prep_case "$S/wlam/case" "$R/wlam"
cat > "$R/wlam/m/prep.sh" <<'EOF'
#!/bin/bash
set -e
blockMesh
topoSet
createPatch -overwrite
rm -rf 0 && mkdir 0 && cp 0.orig/* 0/
for f in 0/*.orig; do mv "$f" "${f%.orig}"; done
setFields
EOF
chmod +x "$R/wlam/m/prep.sh"
cat > "$R/wlam/manifest.yaml" <<'EOF'
apiVersion: sluice/v1alpha1
name: wlam-artifact-run
case:
  path: ./m
mesh:
  strategy: custom
  commands: ["./prep.sh"]
resources:
  partition: all
  nodes: 1
  tasksPerNode: 16
  timeLimitMinutes: 30
solver:
  name: laserWireDEDFoam
runtime:
  foamBashrc: /home/anany/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc
EOF
mkdir -p "$R/wlam"

# --- WAAM (OpenFOAM-10 / Foundation env) -------------------------------------
prep_case "$S/waam/base/damBreak" "$R/waam"
cat > "$R/waam/m/prep.sh" <<'EOF'
#!/bin/bash
set -e
blockMesh
setFields
EOF
chmod +x "$R/waam/m/prep.sh"
cat > "$R/waam/manifest.yaml" <<'EOF'
apiVersion: sluice/v1alpha1
name: waam-artifact-run
case:
  path: ./m
mesh:
  strategy: custom
  commands: ["./prep.sh"]
resources:
  partition: all
  nodes: 1
  tasksPerNode: 16
  timeLimitMinutes: 30
solver:
  name: interFoam
runtime:
  foamBashrc: /home/anany/apps/OpenFOAM/src/OpenFOAM-10/etc/bashrc
EOF
mkdir -p "$R/waam"

echo "staged:"; ls "$R"
