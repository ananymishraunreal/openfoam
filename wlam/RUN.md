# Run WLAM

This folder contains the pinned WLAM case and the existing
`laserWireDEDFoam` build. The binary is preserved in `bin/`; the environment
script puts it ahead of the shared OpenFOAM application directory. No build
or clean stage is run.

Run from this host with Sluice installed:

```bash
./run.sh
```

The manifest prepares the mesh and initial fields while preserving the case's
supported `simple` decomposition method; it does not clean or alter the pinned
source case. Slurm output and Sluice run data stay in `.foam-runs/` and
`.foam-cache/`.
