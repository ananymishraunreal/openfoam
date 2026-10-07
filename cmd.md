# Time & efficiency commands — solo vs cluster (pitzDailySteady)

> `/home/shared` is owned by `amp_user`, so run all writing commands as
> `amp_user`. Either open an amp_user shell first:
>
> ```bash
> sudo -u amp_user bash
> source /opt/openfoam12/etc/bashrc
> ```
>
> or prefix each command with `sudo -u amp_user bash -c '…'`.
> The blocks below assume you are already in the `amp_user` shell.

## Solo (serial, 1 rank)

```bash
cd /home/shared/openfoam/solo_run
rm -rf 100 200 286 log.blockMesh log.foamRun
blockMesh > log.blockMesh 2>&1
/usr/bin/time -v foamRun > log.foamRun 2>&1
grep -E "SIMPLE solution|ExecutionTime" log.foamRun | tail -n 3
grep "^Time = " log.foamRun | tail -n 1
foamListTimes
```

## Cluster (8 ranks, 2 nodes)

```bash
cd /home/shared/openfoam/test1
sbatch run_openfoam.slurm
squeue; sinfo
scontrol show job <JOBID> | grep -E "JobState|ExitCode|RunTime|NodeList"
grep -E "SIMPLE solution|ExecutionTime" log.foamRun | tail -n 3
foamListTimes
```

(`sacct`/`seff` are unusable here — accounting storage is disabled —
so `scontrol … RunTime` is the wall time.)

## Efficiency math

```bash
# speedup    = solo_wall / cluster_wall
# efficiency = speedup / ntasks   (ntasks=8; aim ~50-200k cells/rank for >70%)
python3 /home/shared/openfoam/compare_fields.py 200
```
