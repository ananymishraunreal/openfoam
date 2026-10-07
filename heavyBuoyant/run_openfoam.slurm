#!/bin/bash
#SBATCH --job-name=openfoam-heavyBuoyant
#SBATCH --partition=normal
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --output=/home/shared/openfoam/heavyBuoyant/slurm-%j.out
#SBATCH --error=/home/shared/openfoam/heavyBuoyant/slurm-%j.err

# --- MPI-based OpenFOAM run on SLURM HPC cluster ---
# Case: heavyBuoyant (buoyantCavity geometry, ~630k cells, fluid/buoyant
# solver via foamRun, OpenFOAM 12). Transient natural convection + heat.
# Mesh: blockMesh (~630k cells) -> decomposePar (scotch, 8 ranks, ~79k/rank) ->
#       mpirun foamRun -parallel -> reconstructPar
# All paths are on the shared NFS (/home/shared/...) visible on every node.

set -eo pipefail

echo "=== OpenFOAM MPI job (HEAVY BUOYANT) ==="
echo "Job $SLURM_JOB_ID on nodes: $SLURM_NODELIST"
echo "NTASKS=$SLURM_NTASKS NODES=$SLURM_NNODES"
date

# 1. Environment: identical OpenFOAM 12 on every node (/opt/openfoam12)
# NOTE: foam bashrc can return non-zero in batch shells - guard it from set -e
set +e
source /opt/openfoam12/etc/bashrc
set -e
echo "OpenFOAM $WM_PROJECT_VERSION at $WM_PROJECT_DIR"
which blockMesh decomposePar foamRun reconstructPar
mpirun --version | head -n 1

# 2. Case directory (shared storage - same path on all nodes)
CASE_DIR=/home/shared/openfoam/heavyBuoyant
cd "$CASE_DIR"
pwd; ls

# 3. Clean previous parallel artefacts (safe re-run)
rm -rf processor* log.blockMesh log.decomposePar log.foamRun log.reconstructPar 2>/dev/null || true
# NOTE: blockMesh overwrites constant/polyMesh; keep 0/ constant/ system/ as input

# 4. Mesh (serial)
echo "--- blockMesh (~630k cells) ---"
blockMesh 2>&1 | tee log.blockMesh
echo "Mesh done: $(grep -c . log.blockMesh) log lines"
checkMesh 2>&1 | tail -n 15 || true

# 5. Decompose for $SLURM_NTASKS ranks (must match decomposeParDict)
echo "--- decomposePar ---"
NPROC=$(grep -E "^numberOfSubdomains" system/decomposeParDict | grep -o "[0-9]*")
echo "numberOfSubdomains=$NPROC SLURM_NTASKS=$SLURM_NTASKS"
if [ "$NPROC" != "$SLURM_NTASKS" ]; then
  echo "ERROR: decomposeParDict($NPROC) != sbatch ntasks($SLURM_NTASKS)" >&2
  exit 1
fi
decomposePar 2>&1 | tee log.decomposePar

# 6. Parallel solve via OpenMPI mpirun (SLURM-aware: uses SLURM_NODELIST automatically)
echo "--- foamRun parallel on $SLURM_NTASKS ranks ---"
mpirun -np $SLURM_NTASKS foamRun -parallel 2>&1 | tee log.foamRun
echo "Solver exit: $?"

# 7. Reconstruct for post-processing
echo "--- reconstructPar ---"
reconstructPar 2>&1 | tee log.reconstructPar || echo "reconstructPar warning (check log)"

echo "=== Job finished ==="
date
ls -d processor* 2>/dev/null || echo "processors consumed by reconstruct"
foamListTimes 2>/dev/null || ls
