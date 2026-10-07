# heavySimple — HEAVY but SIMPLE OpenFOAM project

**Simple:** stock `pitzDailySteady` physics — steady backward-facing step,
solver `incompressibleFluid` via `foamRun`, RAS `kEpsilon`. Same `0/`,
`constant/`, `fvSchemes`/`fvSolution` as `solo_run`/`test1`. No new BCs,
no new models.

**Heavy:** same geometry, **64x the mesh** (8x in x, 8x in y, grading kept):

| Block | Base (12,225) | Heavy (~782,400) |
|---|---|---|
| inlet column | (18 30 1) | (144 240 1) |
| main lower | (180 27 1) | (1440 216 1) |
| main upper | (180 30 1) | (1440 240 1) |
| outlet lower | (25 27 1) | (200 216 1) |
| outlet upper | (25 30 1) | (200 240 1) |

~782k cells / 8 ranks = **~98k cells/rank** — inside the 50–200k sweet spot,
so the cluster should now beat solo (the 12k base case was 5x *slower* on
the cluster: comms dominated).

## Layout

```
heavySimple/
  0/ constant/ system/   # case input (system/blockMeshDict is the refined one)
  run_solo.sh            # serial baseline: blockMesh + checkMesh + foamRun
  run_openfoam.slurm     # cluster: blockMesh + decomposePar + mpirun foamRun + reconstructPar
  cleanCase.sh           # foamCleanCase + slurm log cleanup
  Allrun                 # blockMesh + foamRun (tutorial-style)
```

`system/controlDict`: `endTime 2000`, `writeInterval 500` (4 checkpoints;
each ~70 MB ascii at this cell count — ~280 MB total).
`system/decomposeParDict`: `scotch`, 8 subdomains (= sbatch `--ntasks=8`).

## Run

```bash
# as amp_user, OpenFOAM 12:
source /opt/openfoam12/etc/bashrc

# solo (1 rank, minutes):
cd /home/shared/openfoam/heavySimple && ./run_solo.sh

# cluster (8 ranks, 2 nodes):
sbatch /home/shared/openfoam/heavySimple/run_openfoam.slurm
squeue; sinfo
tail -f /home/shared/openfoam/heavySimple/slurm-<JOBID>.out
scontrol show job <JOBID> | grep -E 'JobState|ExitCode|RunTime|NodeList'

# clean:
./cleanCase.sh
```

## Run with foam-clutch (runner test)

```bash
go run ./cmd/foam-clutch validate -manifest /home/shared/openfoam/heavySimple/manifest.yaml
```

`manifest.yaml` (in this dir): `foam-clutch/v1alpha1`, 2 nodes x 4 tasks
(8 ranks, ~98k cells/rank), `partition: normal`, 60 min, solver `foamRun`
(matches `controlDict`: `application foamRun`, `solver incompressibleFluid`).

Notes for the runner test:
- Case ships **input-only** (`0/`, `constant/` without `polyMesh`, `system/`).
  No `processor*` dirs. The runner's generated script runs
  `srun ... foamRun -parallel -fileHandler collated` with no
  `blockMesh`/`decomposePar` step, so mesh + decompose must happen elsewhere
  (pre-staged in the case or added to the pipeline) before `-parallel` can work.
- Preflight-clean by construction: required `0/constant/system` layout,
  no symlinks, and none of the five rejected code-loading directives.
- `system/controlDict` has `runTimeModifiable true`, so the USR1
  `stopAt -> writeNow` checkpoint trap applies.

## Why heavy AND simple

- Heavy = cell count only. Solver cost per SIMPLE iteration scales ~O(N),
  so ~64x cells ≈ 64x work/iteration vs the 5-second base case.
- Simple = nothing else changed. Same turbulence model, same schemes,
  same residual controls — any timing delta is pure mesh/parallel effect.
