#!/bin/bash
#SBATCH --job-name=wlam-short
#SBATCH --partition=all
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --ntasks=2
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --hint=nomultithread
#SBATCH --output='/home/anany/shared_anany/wlam/.foam-runs-short/eb452b91-5ff2-4d99-b621-9c3ea7afa9e8'/slurm-%j.out
#SBATCH --error='/home/anany/shared_anany/wlam/.foam-runs-short/eb452b91-5ff2-4d99-b621-9c3ea7afa9e8'/slurm-%j.err
set -euo pipefail
echo "=== sluice job: wlam-short ==="
echo "solver=laserWireDEDFoam ranks=2 wall=00:10:00 mesh=custom launcher=mpirun fileHandler=collated"
date; echo "nodelist: ${SLURM_NODELIST:-unknown} job: ${SLURM_JOB_ID:-unknown}"

# OpenFOAM environment (per manifest runtime.foamBashrc).
# NOTE: foam bashrc dereferences unset $ZSH_NAME, so drop nounset around it.
set +e +u
source '/home/anany/shared_anany/wlam/foam-env.sh'
set -e -u
echo "OpenFOAM ${WM_PROJECT_VERSION:-unknown} at ${WM_PROJECT_DIR:-unknown}"
export OMP_NUM_THREADS=1
BASHRC='/home/anany/shared_anany/wlam/foam-env.sh'
foam_serial() { bash -c "source $BASHRC && $*"; }
foam_mpi()    { mpirun -np "${NTASKS:-2}" bash -c "source $BASHRC && exec $*"; }

cd '/home/anany/shared_anany/wlam/.foam-runs-short/eb452b91-5ff2-4d99-b621-9c3ea7afa9e8'
pwd; ls

# --- mesh (strategy from manifest) ---
if [ ! -f constant/polyMesh/points ]; then
  echo "--- mesh: blockMesh ---"
  foam_serial 'blockMesh' 2>&1 | tee -a log.mesh
  echo "--- mesh: topoSet ---"
  foam_serial 'topoSet' 2>&1 | tee -a log.mesh
  echo "--- mesh: createPatch -overwrite ---"
  foam_serial 'createPatch -overwrite' 2>&1 | tee -a log.mesh
  echo "--- mesh: mkdir -p 0 && cp 0.orig/* 0/ ---"
  foam_serial 'mkdir -p 0 && cp 0.orig/* 0/' 2>&1 | tee -a log.mesh
  echo "--- mesh: mv 0/U.orig 0/U ---"
  foam_serial 'mv 0/U.orig 0/U' 2>&1 | tee -a log.mesh
  echo "--- mesh: mv 0/alpha.metal.orig 0/alpha.metal ---"
  foam_serial 'mv 0/alpha.metal.orig 0/alpha.metal' 2>&1 | tee -a log.mesh
  echo "--- mesh: mv 0/cWire.orig 0/cWire ---"
  foam_serial 'mv 0/cWire.orig 0/cWire' 2>&1 | tee -a log.mesh
  echo "--- mesh: setFields ---"
  foam_serial 'setFields' 2>&1 | tee -a log.mesh
else
  echo "--- mesh skipped (constant/polyMesh exists) ---"
fi

# --- decompose (idempotent) ---
echo "--- decomposePar check ---"
NPROC=$(grep -E "^numberOfSubdomains" system/decomposeParDict | grep -o "[0-9]*")
NTASKS=${SLURM_NTASKS:-2}
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
echo "--- mpirun laserWireDEDFoam -parallel -fileHandler collated ---"
set +e
foam_mpi 'laserWireDEDFoam -parallel -fileHandler collated' > log.solver 2>&1
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
