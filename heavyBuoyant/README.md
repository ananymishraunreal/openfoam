# heavyBuoyant — HEAVY but SIMPLE OpenFOAM project (transient buoyant heat transfer)

**Different functionality from `heavySimple`:** that case is steady,
isothermal, incompressible RANS (`SIMPLE`, backward-facing step).
This case is **transient natural convection with heat transfer** in a tall
cavity (hot right wall, cold left wall), solver `fluid` (buoyant) via
`foamRun`, `PIMPLE` pressure-velocity coupling, RAS `kOmegaSST`, perfect-gas
thermo (`heRhoThermo`). Extra fields vs heavySimple: `T`, `p_rgh`, `alphat`,
`h` (energy), plus `g` and `pRef` in `constant/`.

**Heavy:** same cavity geometry, **8x the mesh** (2x in every direction):

| Mesh | x | y | z | cells |
|---|---|---|---|---|
| Base tutorial | 35 | 150 | 15 | 78,750 |
| Heavy (this) | 70 | 300 | 30 | **630,000** |

~630k cells / 8 ranks = **~79k cells/rank** — inside the 50–200k sweet spot.
3D mesh (`frontAndBack` are walls, not `empty` — unlike heavySimple's 2D case).
`controlDict` kept as tutorial: `endTime 1000`, `deltaT 1` (1000 PIMPLE
steps), `writeInterval 50`, `purgeWrite 3` (only the last 3 checkpoints kept,
so disk stays bounded).
`system/decomposeParDict`: `scotch`, 8 subdomains (= sbatch `--ntasks=8`).

## Layout

```
heavyBuoyant/
  0/ constant/ system/   # case input (system/blockMeshDict is the refined one)
  manifest.yaml          # foam-clutch manifest (solver foamRun, 2 nodes x 4)
  run_solo.sh            # serial baseline: blockMesh + checkMesh + foamRun
  run_openfoam.slurm     # cluster: blockMesh + decomposePar + mpirun foamRun + reconstructPar
  cleanCase.sh           # foamCleanCase + slurm log cleanup
  Allrun                 # blockMesh + foamRun (tutorial-style)
```

Deliberately **excluded** from the tutorial: `system/sample` (post-processing
`sets` dict) — it contains a library-loading entry for the sampling library,
which foam-clutch preflight rejects. It is only used by an explicit
`foamPostProcess -func sample` call, never by the solver.

## Run

```bash
# as amp_user, OpenFOAM 12:
source /opt/openfoam12/etc/bashrc

# solo (1 rank):
cd /home/shared/openfoam/heavyBuoyant && ./run_solo.sh

# cluster (8 ranks, 2 nodes):
sbatch /home/shared/openfoam/heavyBuoyant/run_openfoam.slurm

# clean:
./cleanCase.sh
```

## Run with foam-clutch (runner test)

```bash
go run ./cmd/foam-clutch validate -manifest /home/shared/openfoam/heavyBuoyant/manifest.yaml
```

Notes for the runner test:
- Case ships **input-only** (`0/`, `constant/`, `system/`). No `processor*`
  dirs, no `polyMesh`. No `setFields`/preprocessing step is needed for this
  case (unlike `damBreak`/`shockTube`, which need one) — only `blockMesh`,
  which the runner's generated script does not do either. Same mesh/decompose
  note as heavySimple applies: the generated script runs
  `srun ... foamRun -parallel -fileHandler collated` directly.
- Preflight-clean by construction: required `0/constant/system` layout,
  no symlinks, and none of the five rejected code-loading directives.
- `system/controlDict` has `runTimeModifiable true`, so the USR1
  `stopAt -> writeNow` checkpoint trap applies. 1000 transient steps is a
  good checkpoint/requeue exercise if the wall clock is tight.
