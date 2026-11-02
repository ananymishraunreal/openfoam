# SLUICE fixtures — shared memory area

Three additive-manufacturing fixture projects for Sluice testing, fetched at
pinned commits with per-file SHA-256 manifests. The cases stay OUT of the
Sluice repo (solvers and upstream cases are GPL / unlicensed — see notes in
each project README); only this writable fixture tree holds them.

```
lpbf/   laserbeamFoam LPBF_small  @ 3827840e600b6c15fe7eeb19d437c4f2a33b4c4f (GPL-3.0)
wlam/   dukyong414 laser-wire-ded coarse_lof @ 9fc736e99d61852a306b3f8e67022d368fc669dd (NO LICENSE — internal only)
waam/   OpenFOAM-10 damBreak @ 89f925dc708d068f84f51e8317e3bebcda64f5cb (GPL, stock interFoam)
        + laserbeamFoam fiveLasersOnSubstrate @ 3827840e600b6c15fe7eeb19d437c4f2a33b4c4f (GPL-3.0, reference only)
```

## Policy (your words, locked in)

- Fixtures are RAW: fetched cases verbatim. No run scripts, no sbatch, no
  HPC tuning, no variant knobs shipped here.
- Sluice generates whatever runtime machinery is needed during its manifest
  phase; when that happens, generated files live beside the fixture, not
  committed here.
- Do not commit *this* tree to the Sluice repo.

## Layout

- `<project>/<case or base / reference>` — the fetched OpenFOAM case contents,
  byte-identical to the pinned upstream (see `MANIFEST.json` + `.SOURCE`).
- `<project>/MANIFEST.json` — project metadata + per-file sha256.
- `<project>/README.md` — provenance, case facts, license notes.
- `bin/fetch_case.sh` — pinned sparse fetch (repo, commit, sparse path, dest).
- `bin/make_manifest.py` — regenerate a project MANIFEST.json after changes.

## Re-pinning or re-fetching

```bash
# replay the LPBF fetch against the pinned commit
bin/fetch_case.sh https://github.com/laserbeamfoam/LaserbeamFoam \
  3827840e600b6c15fe7eeb19d437c4f2a33b4c4f <dest> tutorials/laserbeamFoam/LPBF_small
# then regenerate its manifest with bin/make_manifest.py
```

All three project SHAs were verified at fetch time (2026-10-29). If upstream
moves ahead of these pins, the fixtures still replay to the historical commit
— that is the point of pinning.
