# OpenFOAM on HPC — Distributed MPI Run: `test1` (pitzDailySteady)

## 1. What this is

- **Case dir (shared on all nodes):** `/home/shared/openfoam/test1`
- **Case:** `pitzDailySteady` from OpenFOAM 12 tutorials
  (`$FOAM_TUTORIALS/incompressibleFluid/pitzDailySteady`), i.e. steady
  backward-facing-step, solver `incompressibleFluid` via `foamRun`.
- **Change vs stock tutorial:** `system/controlDict` `endTime 2000 -> 500`
  (stock writes every 100 steps; here we converge in ~296 iterations, ~28 s
  on 8 ranks — fast enough for a cluster smoke test; set back to `2000`
  for the full tutorial).
- **Batch script:** `run_openfoam.slurm` (MPI + SLURM, see §4).
- **Proven run:** SLURM job **20**, `COMPLETED, ExitCode 0:0`,
  `RunTime 00:00:28`, nodes `5-[167-168]`, 8 ranks (4+4),
  `SIMPLE solution converged in 296 iterations`, times `0 100 200 296`
  reconstructed.

## 2. Cluster layout (as built)

| Node | IP | CPUs / RAM | Role |
|------|----|------------|------|
| 5-166 | 172.16.5.166 | 8 / 7708 MB | SLURM controller (`slurmctld` + `slurmd`), NFS server |
| 5-167 | 172.16.5.167 | 8 / 7708 MB | compute (`slurmd`) |
| 5-168 | 172.16.5.168 | 8 / 7708 MB | compute (`slurmd`) |

- Partitions: `normal` (default) = `5-167,5-168`; `all` = `5-166,5-167,5-168`.
- OS: Ubuntu 20.04.6 LTS (focal) on all nodes.
- OpenFOAM: **12** (`openfoam12` 20250206 from `dl.openfoam.org`) in
  `/opt/openfoam12` on **all three** nodes (installed via apt; workers
  5-167/5-168 were missing it and got the same install).
- MPI: Open MPI 4.0.3 (`/usr/bin/mpirun`) on all nodes.
- Shared storage: `/home/shared`, NFSv4 from `5-166`
  (`5-166:/home/shared`, export `172.16.5.0/24`), owner `amp_user:amp_user`
  mode `2775`. **Run everything in the share as user `amp_user`**
  (the share is not writable by `administrator`).
- Activate OpenFOAM in any shell: `source /opt/openfoam12/etc/bashrc`.

## 3. Why it was "not running" (root causes fixed)

1. **Stale NFS mount froze `/home/shared`.** All nodes had
   `SRMS1:/home/shared (addr=172.16.5.165)` mounted — a leftover from the
   old WSL-based setup. Port 2049/111 on .165 answered but the server
   never replied, so every `ls` / job touching `/home/shared` hung in
   `D` state (`ls /home/shared` timed out, `sbatch` jobs died).
   Fix: `sudo umount -l /home/shared` on 5-166/5-167/5-168, then
   `sudo mount /home/shared` on workers (fstab already said
   `5-166:/home/shared`). Host now serves its local dir; workers mount
   `5-166:/home/shared` (124G). Marker `/home/shared/.served_by`
   = `hpc-shared served from 5-166`.
   NOTE: the old data (`anany_cluster*`, `opt.tar.xz` 2.4G) still lives
   on 172.16.5.165, not in the new share — copy it over if needed.
2. **SLURM `UNKNOWN*` before that** was a Munge key reload issue
   (`Munge decode failed: Invalid credential` in `slurmctld.log`);
   fixed with `systemctl restart munge` on all nodes + `slurmctld/slurmd`
   restarts. `sinfo` now: `normal: 2 idle`, `all: 3 idle`.
3. **Batch script bugs found while bringing the case up:**
   - `set -euo pipefail` + `source /opt/openfoam12/etc/bashrc` aborts
     (bashrc references `$ZSH_NAME` / returns non-zero in batch shells).
     Fix: `set -eo pipefail` and guard the source with `set +e … set -e`.
   - `srun foamRun -parallel` → `MPI_Init_thread on NULL communicator`.
     OpenFOAM's OpenMPI here does not do direct `srun` launch; use
     `mpirun -np $SLURM_NTASKS foamRun -parallel` (SLURM-aware, reads
     `SLURM_NODELIST`, no hostfile).
   - Script deleted its own `slurm-*.out` mid-run (`rm … slurm-*.out`);
     clean line now only removes `processor*` + `log.*`.

## 4. The sbatch script (`run_openfoam.slurm`)

```bash
#SBATCH --job-name=openfoam-test1
#SBATCH --partition=normal     # workers only (use `all` to include 5-166)
#SBATCH --nodes=2
#SBATCH --ntasks=8             # MUST equal decomposeParDict numberOfSubdomains
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --output=/home/shared/openfoam/test1/slurm-%j.out
#SBATCH --error=/home/shared/openfoam/test1/slurm-%j.err
```

Pipeline inside (all in `$CASE_DIR=/home/shared/openfoam/test1`):

1. `source /opt/openfoam12/etc/bashrc` (guarded, see §3).
2. `rm -rf processor* log.blockMesh log.decomposePar log.foamRun log.reconstructPar`
3. `blockMesh` (serial meshing, ~12k cells).
4. Sanity check `numberOfSubdomains (system/decomposeParDict) == $SLURM_NTASKS`, then `decomposePar` (method `scotch`, 8 subdomains).
5. `mpirun -np $SLURM_NTASKS foamRun -parallel` (distributed solve).
6. `reconstructPar` (serial, for post-processing).

## 5. Run / monitor / inspect

```bash
sudo -u amp_user sbatch /home/shared/openfoam/test1/run_openfoam.slurm
squeue; sinfo
tail -f /home/shared/openfoam/test1/slurm-<JOBID>.out
tail -f /home/shared/openfoam/test1/log.foamRun
scontrol show job <JOBID> | grep -E 'JobState|ExitCode|RunTime|NodeList'
# after completion:
source /opt/openfoam12/etc/bashrc
cd /home/shared/openfoam/test1 && foamListTimes   # 0 100 200 296
ls processor*  # decomposed fields; reconstructed into time dirs
```

Reference output (job 20): `slurm-20.out` ends with `reconstructPar … End`
+ `=== Job finished ===`; `log.foamRun` ends with
`SIMPLE solution converged in 296 iterations … Finalising parallel run`
with ranks listed as `5-167.x` / `5-168.x` (proof of distribution).

## 6. Adapting it

- **More ranks:** set `--ntasks=N` *and* `system/decomposeParDict`
  `numberOfSubdomains N` to the same value (script aborts otherwise).
  Max here: 16 on `normal` (2×8), 24 on `all` (3×8).
- **Full tutorial:** `endTime 500 -> 2000` in `system/controlDict`.
- **Other cases:** copy any `$FOAM_TUTORIALS/...` case into
  `/home/shared/openfoam/<name>`, add a matching `decomposeParDict`,
  point `CASE_DIR` at it (or copy this sbatch script next to it).
- **Post:** `paraFoam` needs a display; on headless nodes use
  `reconstructPar` + copy time dirs locally, or `foamToVTK` + ParaView.
- **Releases:** `sudo apt update && sudo apt install --only-upgrade openfoam12`
  on each node (keep versions identical or MPI runs fail).

## 7. Cleaning the case (`cleanCase.sh`)

- **Script:** `cleanCase.sh` (executable, runs as `amp_user`).
- **Run it:** `./cleanCase.sh` (cleans test1) or
  `./cleanCase.sh -case /home/shared/openfoam/<other>` for another case.
- **Does:** `foamCleanCase` (removes `processor*`, time dirs `100 200 296`,
  `constant/polyMesh`, `postProcessing`, `log.*`) + removes `slurm-*.out/err`.
- **Keeps:** `0/`, `constant/*` properties, `system/`, scripts, README.
- **Verify it worked (run after cleaning):**
  `ls` (no `processor*`, no `100/200/296`, no `log.*`),
  `foamListTimes` (empty = only `0/` left),
  `ls 0/` (fields still there), `ls system/` (dicts still there),
  `ls constant/` (no `polyMesh` until you re-mesh).
- **Re-run after clean:** `sbatch run_openfoam.slurm` (it re-meshes).
