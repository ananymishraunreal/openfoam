# Run LPBF

This folder contains the pinned LPBF case, the existing `laserbeamFoam` build,
and a Sluice manifest for the OpenFOAM v2506 environment on this host. The
binary is preserved in `bin/`; the environment script puts it ahead of the
shared OpenFOAM application directory. No build or clean stage is run.

Run from this host with Sluice installed:

```bash
./run.sh
```

The manifest generates the mesh before solving, preserving the case's
supported `simple` decomposition method. `case/0/` is a compatibility copy
of `case/initial/`; the pinned fixture in `shared_memory` remains unchanged.
Slurm output and Sluice run data stay in `.foam-runs/` and `.foam-cache/`.
