#!/bin/bash
#SBATCH --job-name=lpbf-artifact-run
#SBATCH --partition=all
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --ntasks=16
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --hint=nomultithread
#SBATCH --output='/home/anany/shared_memory/run-scratch/sluice/lpbf/.foam-runs/56f13987-87f1-43c3-8d4a-cb58ddc8c8c3'/slurm-%j.out
#SBATCH --error='/home/anany/shared_memory/run-scratch/sluice/lpbf/.foam-runs/56f13987-87f1-43c3-8d4a-cb58ddc8c8c3'/slurm-%j.err
set -euo pipefail
echo "=== sluice job: lpbf-artifact-run ==="
echo "solver=laserbeamFoam ranks=16 wall=00:30:00 mesh=custom launcher=mpirun fileHandler=collated"
date; echo "nodelist: ${SLURM_NODELIST:-unknown} job: ${SLURM_JOB_ID:-unknown}"

# OpenFOAM environment (per manifest runtime.foamBashrc).
# NOTE: foam bashrc dereferences unset $ZSH_NAME, so drop nounset around it.
set +e +u
source '/home/anany/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc'
set -e -u
echo "OpenFOAM ${WM_PROJECT_VERSION:-unknown} at ${WM_PROJECT_DIR:-unknown}"
export OMP_NUM_THREADS=1
BASHRC='/home/anany/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc'
foam_serial() { bash -c "source $BASHRC && $*"; }
foam_mpi()    { mpirun -np "${NTASKS:-16}" bash -c "source $BASHRC && exec $*"; }

cd '/home/anany/shared_memory/run-scratch/sluice/lpbf/.foam-runs/56f13987-87f1-43c3-8d4a-cb58ddc8c8c3'
pwd; ls

# --- build (compile if necessary, manifest build.source) ---
if ! command -v laserbeamFoam >/dev/null 2>&1; then
  echo "--- build: laserbeamFoam not on PATH; running build.commands ---"
  echo "--- build cmd: cd /home/anany/apps/solvers/laserbeamFoam && ./Allwmake ---" >> log.build
  foam_serial 'cd /home/anany/apps/solvers/laserbeamFoam && ./Allwmake' >> log.build 2>&1 || { echo "ERROR: build command failed: cd /home/anany/apps/solvers/laserbeamFoam && ./Allwmake (see log.build)"; exit 1; }
  command -v laserbeamFoam >/dev/null 2>&1 || { echo "ERROR: laserbeamFoam still not on PATH after build stage (see log.build)"; exit 1; }
else
  echo "--- build skipped (laserbeamFoam already on PATH) ---"
fi

# --- mesh (strategy from manifest) ---
if [ ! -f constant/polyMesh/points ]; then
  echo "--- mesh: ./prep.sh ---"
  foam_serial './prep.sh' 2>&1 | tee -a log.mesh
else
  echo "--- mesh skipped (constant/polyMesh exists) ---"
fi

# --- decompose (idempotent) ---
echo "--- decomposePar check ---"
NPROC=$(grep -E "^numberOfSubdomains" system/decomposeParDict | grep -o "[0-9]*")
NTASKS=${SLURM_NTASKS:-16}
echo "numberOfSubdomains=$NPROC NTASKS=$NTASKS"
if [ "$NPROC" != "$NTASKS" ]; then
  echo "ERROR: decomposeParDict($NPROC) != ntasks($NTASKS)" >&2
  exit 1
fi
HAVE_PROC=0
shopt -s nullglob
PROC_DIRS=(processor*)
HAVE_PROC=${#PROC_DIRS[@]}
shopt -u nullglob
if [ "$HAVE_PROC" != "$NTASKS" ]; then
  echo "--- decomposePar ($HAVE_PROC -> $NTASKS) ---"
  rm -rf processor* 2>/dev/null || true
  foam_serial 'decomposePar' 2>&1 | tee log.decomposePar
else
  echo "--- decomposePar skipped ($HAVE_PROC processor dirs) ---"
fi

# --- solver (from manifest solver.name/arguments) ---
if [ -f system/controlDict ]; then
  foam_serial 'foamDictionary -entry startFrom -set latestTime system/controlDict' || true
fi
echo "--- mpirun laserbeamFoam -parallel -fileHandler collated ---"
set +e
foam_mpi 'laserbeamFoam -parallel -fileHandler collated' > log.solver 2>&1
SOLVER_RC=$?
set -e
echo "solver exit: $SOLVER_RC"
tail -n 20 log.solver || true

# --- post ---
if [ "$SOLVER_RC" -eq 0 ] && [ ! -f .foam-checkpoint-requested ]; then
  echo "--- post skipped (no reconstruct/commands) ---"
else
  echo "--- post skipped (solver rc=$SOLVER_RC or checkpoint requested) ---"
fi
exit $SOLVER_RC
