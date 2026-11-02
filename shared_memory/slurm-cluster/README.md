# slurm-cluster — single-node Slurm + OpenFOAM on Omarchy

Scripts for the laptop's one-node cluster. Nothing here RUNS the fixture
cases — it only installs infrastructure and builds solvers (per policy: Sluice
generates runners during manifest; these are plumbing deps).

## Run order

1. **`install-cluster-sudo.sh`** — sudo once:
   ```
   sudo bash install-cluster-sudo.sh
   ```
   - pacman: munge, openmpi, build deps
   - builds SchedMD Slurm into /usr/local from official tarball
     (Arch repos/AUR have no proper slurm package)
   - writes /etc/slurm/slurm.conf (single node), munge key, systemd units
     (slurmctld as slurm user, slurmd as root), enables all, smoke checks
     sinfo + srun hostname.

2. **`install-openfoam-2506.sh`** — no sudo (runs in your user shell):
   builds OpenFOAM **v2506 (ESI)** from official tarballs into
   `~/apps/OpenFOAM` — matches laserbeamFoam's CI (`opencfd/openfoam-dev:2506`).

3. **`build-am-solvers.sh`** — no sudo:
   - clones laserbeamFoam @ `OpenFoam_com_main` and builds against v2506
   - clones laser-wire-ded-project util `9fc736e9…` and builds
     `solver/laserWireDEDFoam` (upstream README used v2406; v2506 tried first)

4. **`install-openfoam-org10.sh`** — no sudo:
   builds **OpenFOAM-10 (Foundation)** for the damBreak fixture (its dicts
   use Foundation field naming: physicalProperties.air/.water). Uses system
   openmpi from step 1.

## Environment sourcing

```bash
# v2506 (default fixtures)
source ~/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc
# Foundation org-10
source ~/apps/OpenFOAM/src/OpenFOAM-10/etc/bashrc
```

## Fixture → environment mapping

| Fixture | Solver binary | Needs |
|---|---|---|
| lpbf (LPBF_small) | laserbeamFoam-family (v2.0 repo: `laserbeamFoam`) | v2506 build of pinned LaserbeamFoam |
| wlam (coarse_lof) | `laserWireDEDFoam` | v2506 build of pinned solver (fallback: v2406) |
| waam base (damBreak) | `interFoam` (stock) | org-10 install |
| waam reference | laserbeamFoam-family | same v2506 install |

## USR1 / requeue

Slurm is configured with auth/munge, proctrack/pgid — plain `sbatch
--signal=B:USR1@60` works; it is what Sluice's runner is expected to use.

## Maintenance notes

- Slurm lives in /usr/local (prefix). Update = rerun installer (it fetches the
  newest available of 25.05/24.11/23.11 builds).
- If you ever want accounting or a job scheduler other than builtin, edit
  /etc/slurm/slurm.conf and restart slurmctld/slurmd.

## Build resume (v2506 core partially built)

The v2506 core build was stopped mid-way on Oct-29 (~2,650 object files
preserved under `~/apps/OpenFOAM/OpenFOAM-v2506/build/` — make/wmake reuses
them; only the remainder compiles). To finish everything:

```
# no sudo needed; downloads are cached
bash ~/shared_memory/slurm-cluster/install-openfoam-2506.sh   && \
bash ~/shared_memory/slurm-cluster/build-am-solvers.sh
```

Check success with: `source ~/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc && \
command -v laserbeamFoam` (binary lands in $FOAM_USER_APPBIN).
Log: `~/shared_memory/slurm-cluster/build-logs/openfoam-v2506.out`.
