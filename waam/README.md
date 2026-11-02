# WAAM fixture (wire-arc additive manufacturing surrogate)

No honest open WAAM case turned up in the research pass. This is therefore a
surrogate assembled from two open pieces:

## base/damBreak — plain OpenFOAM-10 VOF case
- Pinned (pinned fetch): `tutorials/multiphase/interFoam/laminar/damBreak`
  from https://github.com/OpenFOAM/OpenFOAM-10 @
  `89f925dc708d068f84f51e8317e3bebcda64f5cb`. License GPLv3 verbatim in
  `base/LICENSE.openfoam-10` (repo root `COPYING`).
- Facts: solver `interFoam`, `endTime 1`, `deltaT 0.001`, `maxCo 1`,
  `writeControl adjustableRunTime` `writeInterval 0.05`,
  `decomposeParDict numberOfSubdomains 4`.
- Suitable as the plumbing fixture: standard solver, nothing custom, small
  mesh, quick wall times — the case family used to exercise Sluice end to end
  on every pipeline change.

## reference/fiveLasersOnSubstrate — moving-heat-source concept reference
- Pinned fetch: `tutorials/laserbeamFoam/fiveLasersOnSubstrate`
  from https://github.com/laserbeamfoam/LaserbeamFoam @
  `3827840e600b6c15fe7eeb19d437c4f2a33b4c4f`. GPL-3.0 verbatim in
  `reference/LICENSE.laserbeamFoam`.
- Carries five indexed scan tables (`constant/timeVsLaserPosition0..4`,
  `constant/timeVsLaserPower0..4`) plus `LaserProperties` — the closest open
  stand-in structure for "a heat source travelling over a growing bead"
  (what a WAAM surrogate would need).
- Solver: same laserbeamFoam-family build as lpbf (see lpbf/README.md).

## Sluice use
- `base/damBreak` — small, stock, always-safe fixture; runs on a plain
  OpenFOAM install without custom solvers, so it covers the cold-path.
- The WAAM-like surrogate behaviour (bead growing under a moving heat source)
  is described here only in intent; a concrete crafted WAAM case is a
  future/your-own-synthetic fixture.

**Run policy:** fixtures are raw. No run scripts, no HPC tuning, no Sluice
glue here — Sluice auto-generates run scripts during its manifest phase.
