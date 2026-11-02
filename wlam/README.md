# WLAM fixture (wire-laser additive manufacturing surrogate)

**Purpose:** stand-in case family for wire+ laser additive processes while no
open official WLAM case exists. Exercises the two-phase + melt-pool-like
trajectory that the LPBF fixture covers, with an actual moving wire source.

**Source (pinned):** `cases/coarse_lof` case plus repo README/START-HHERE
documentation copy, from
https://github.com/dukyong414/laser-wire-ded-project @
`9fc736e99d61852a306b3f8e67022d368fc669dd`. See `MANIFEST.json` (per-file
SHA-256) and `.SOURCE` in `case/`.

**License caution:** that repo ships **no LICENSE file** (as of the pinned
commit). This copy is included in this repository with redistribution
permission confirmed by the repository owner. That permission does not create
a general license for the upstream project; obtain separate permission before
reusing its files elsewhere.

**Case facts (verified at fetch):**
- `system/controlDict`: solver `laserWireDEDFoam`, `endTime 0.5`,
  `deltaT 1e-7`, `maxCo 0.4`, `startTime 0`
- `system/decomposeParDict`: `numberOfSubdomains 2` (leave as-is; Sluice's
  manifest phase decides rank knobs)
- The case directory also carries the author's own generated artifacts
  (`run_log_head.txt`, `run_log_tail.txt`, `checkMesh_tail.txt`,
  `case_params.json`) — shipped verbatim; do not treat them as canonical
  Sluice state but as upstream leftovers.
- Custom solver: `laserWireDEDFoam` — a compiled OpenFOAM.com solver from the
  same repo (`solver/laserWireDEDFoam/`). Not part of this fixture (Sluice's
  manifest phase points at source builds; the design decision about compiled
  `libs` allow-lists applies here).

**Reference discussions (links from the research pass):**
- Moving-wire DED thread:
  https://github.com/laserbeamfoam/LaserbeamFoam/discussions/112
- laserbeamFoam ray-tracing forum thread:
  https://www.cfd-online.com/Forums/openfoam-community-contributions/245213-laserbeamfoam-laser-ray-tracing-openfoam.html
- Melting with icoReactingMultiPhaseInterFoam (ESI fork):
  https://www.cfd-online.com/Forums/openfoam-solving/230733-melting-using-icoreactingmultiphaseinterfoam.html

**Run policy:** fixtures are raw here. No run scripts, no tuned ranks, no
HPC sweetness — Sluice auto-generates those during its manifest phase.
