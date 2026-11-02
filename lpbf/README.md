# LPBF fixture (laser powder bed fusion)

**Purpose:** Sluice fixture family — long two-phase (VOF) runs with small time
steps. Exercises: run, cache hit/miss, `list`, `logs`, tail, status polling,
checkpoint and requeue (pair with a deliberately short Slurm wall time).

**Source (pinned, held at fetched case ritual):** laserbeamFoam tutorials
`tutorials/laserbeamFoam/LPBF_small` from
https://github.com/laserbeamfoam/LaserbeamFoam @ `3827840e600b6c15fe7eeb19d437c4f2a33b4c4f`.
See `MANIFEST.json` (per-file SHA-256) and `.SOURCE` in `case/`. License: the
solver + case are GPL-3.0 (`../LICENSE.laserbeamFoam` fetched verbatim from the
repo). The case is NOT committed to the Sluice repo — it lives here, in the
shared fixture area, and is re-fetchable through `bin/fetch_case.sh`.

**Solver:** the case's own copy of `Allrun` uses the
`laserBeamFoam`-based tutorial setup (state-of-repo: `Flint_multiphaseEulerFoamD`
appears in `system/controlDict`; the tutorial's Allrun binary is
`laserbeamFoam`). Whatever the READMEs in the git repo disagree on, build the
solver from the same pinned repo/branch (`OpenFoam_com_main`) and enter the
executable name in `run.sbatch` (`SOLVER=`). The pin is the current head — the
2.0-era solver naming is still in flux upstream; if upstream moves, re-pin via
`bin/fetch_case.sh`.

**Case facts (verified at fetch):**
- `system/controlDict`: `endTime 100e-6`, `deltaT 1.0e-8` (10 k steps),
  `writeControl adjustableRunTime`, `writeInterval 5e-6` (20 writes),
  `startFrom latestTime`
- `system/decomposeParDict`: `numberOfSubdomains 32`, method `simple`;
  `run.sbatch` overrides it to `$SLURM_NTASKS` with `method scotch`, so the
  number of ranks is a free knob.
- Powder bed is pre-computed (LIGGGHTS DEM step optional; `DEM_small/` is
  retained but DEM is skipped unless `liggghts` is on PATH).
- Mesh prep (from the case `Allrun`, minus the run): copy `initial` → `0`,
  `blockMesh`, `setSolidFraction -subDivisions 6`,
  `transformPoints -rotate '((0 1 0) (0 0 1))'`. Happens automatically inside
  `run.sbatch` on first run; the source `case/` stays pristine.

**Policy reminder:** fixtures here are raw fetched cases — no run scripts, no
HPC tuning, no Sluice glue. Sluice auto-generates run scripts during its
manifest phase. Use `bin/fetch_case.sh` (pinned replay of the fetch) if the
need to re-pin comes up; vary the case by hand or through Sluice, not here.

**Sluice test hooks to remember:**
- Case `case/README.md` (upstream todays tutorial) has the full physics background.
- `grep '^ *libs' case/system/controlDict` shows whether custom library loading
  is present (preflight's allow-list item) — treat any hit here as a live ref
  test for the "admin-pinned libs" feature shape.
