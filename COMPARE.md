# Solo vs Cluster — pitzDailySteady output comparison

Same case, same mesh (12,225 cells), same `endTime 500`: once **solo**
(serial, 1 rank, no MPI) and once on the **cluster** (8 ranks, scotch,
2 nodes). Both converged to the same steady state.

## Setup

| | SOLO (`solo_run/`) | CLUSTER (`test1/`, job 23) |
|---|---|---|
| Machine | 5-166 only | 5-167 + 5-168 via SLURM `normal` |
| Ranks | 1 (serial `foamRun`) | 8 (`mpirun -np 8 foamRun -parallel`) |
| Launch | `./run_solo.sh` on 5-166 | `sbatch run_openfoam.slurm` |
| Decompose | none | `decomposePar` scotch + `reconstructPar` |

## Results

| Metric | SOLO | CLUSTER | Note |
|---|---|---|---|
| Wall time | **5 s** | **28 s** | cluster = mesh + decompose + solve + reconstruct + MPI startup |
| Solver `ExecutionTime` | 4.57 s | 21.6 s (slowest rank) | small case: comms dominate |
| Iterations to converge | 286 | 296 | path differs slightly (processor boundaries, GAMG agglomeration) |
| Final Ux residual | 1.19e-05 | 9.61e-06 | same order, both converged |
| Final Uy residual | 6.71e-05 | 7.22e-05 | ditto |
| Final p residual | 1.05e-04 | 1.24e-04 | ditto |
| Final k / epsilon | 1.34e-05 / 8.79e-06 | 1.38e-05 / 1.01e-05 | ditto |

## Field differences (cell-by-cell, common time 200, 12,225 cells)

| Field | max abs diff | mean abs diff | rel. to range |
|---|---|---|---|
| U | 1.05e-01 | 5.5e-03 | 0.8% |
| p | 4.83e-01 | 9.5e-02 | 2.1% |
| k | 1.61e-01 | 1.5e-02 | 2.7% |
| epsilon | 3.61e+01 | 1.5e+00 | 0.6% |

Computed with `compare_fields.py` (parses `internalField` lists; mesh
ordering is identical after `reconstructPar`, so direct comparison is valid).

## Interpretation

- **Outputs are equivalent:** residuals land in the same decade, fields
  agree to ~1–3% at the same iteration — expected: domain decomposition
  changes round-off/aggregation order, and the two runs converged at
  slightly different iterations (286 vs 296). For engineering purposes
  this is the same solution.
- **Cluster was ~5× SLOWER here (28 s vs 5 s)** — normal for a 12k-cell
  case: halo exchange + GAMG collectives + decompose/reconstruct cost more
  than the compute they save. Clusters pay off on large meshes (millions
  of cells) where one machine runs out of RAM/cores; rule of thumb:
  ~50–200k cells per rank.
- To reproduce: clean both (`./cleanCase.sh [-case …]`), rerun solo
  (`./run_solo.sh`) and cluster (`sbatch run_openfoam.slurm`), then
  `python3 /home/shared/openfoam/compare_fields.py 200` and
  `grep -E 'SIMPLE solution|ExecutionTime' <log>`.
