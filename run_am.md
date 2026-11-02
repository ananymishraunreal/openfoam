# Running the LPBF and WLAM projects with Sluice

This guide covers getting the project checkout, building the custom solver
binaries when needed, making a short artifact-producing run, and submitting
the full cases through Sluice to Slurm.

## 1. Clone the project

The projects are on PR #2. Until it is merged, fetch its branch:

```bash
git clone https://github.com/ananymishraunreal/openfoam.git "$HOME/shared_anany"
cd "$HOME/shared_anany"
git fetch origin pull/2/head:add-lpbf-wlam-projects
git switch add-lpbf-wlam-projects
```

The solver binaries are included under `lpbf/bin/` and `wlam/bin/`. Keep these
files: do not run `Allwclean`, `wclean`, or `sluice clean`. The supplied
`foam-env.sh` scripts put the bundled binaries on `PATH`.

## 2. Set up Sluice and OpenFOAM

Install Sluice on the submit host and confirm Slurm commands are available:

```bash
go install github.com/ananymishradev/sluice/cmd/sluice@latest
export PATH="$HOME/go/bin:$PATH"
sluice version
sinfo
```

The manifests currently source OpenFOAM v2506 from
`/home/anany/apps/OpenFOAM/OpenFOAM-v2506/etc/bashrc`. Edit each project's
`foam-env.sh` if the installation is elsewhere. The project checkout,
OpenFOAM environment, binaries, and solver build directories must be visible
at the same paths from compute nodes.

## 3. Build the custom solver binaries (optional)

The checked-in binaries already work with this host's OpenFOAM v2506 build;
skip this section when using them. To compile for a different compatible
OpenFOAM installation, source its environment first. Builds write into
`$FOAM_USER_APPBIN`, which is separate from the checked-in copies in `bin/`.

Build LPBF's solver from its pinned source:

```bash
git clone --branch OpenFoam_com_main \
  https://github.com/laserbeamfoam/LaserbeamFoam.git \
  "$HOME/apps/solvers/laserbeamFoam"
cd "$HOME/apps/solvers/laserbeamFoam"
git checkout 3827840e600b6c15fe7eeb19d437c4f2a33b4c4f
source /path/to/OpenFOAM-v2506/etc/bashrc
./Allwmake
```

Build WLAM's solver from its pinned source:

```bash
git clone https://github.com/dukyong414/laser-wire-ded-project.git \
  "$HOME/apps/solvers/laser-wire-ded-project"
cd "$HOME/apps/solvers/laser-wire-ded-project"
git checkout 9fc736e99d61852a306b3f8e67022d368fc669dd
source /path/to/OpenFOAM-v2506/etc/bashrc
cd solver/laserWireDEDFoam
wmake
```

The WLAM upstream repository has no license. The case is included in this
project with the repository owner's redistribution permission; check with the
upstream owner before using it elsewhere.

Check that both solvers resolve after sourcing the matching `foam-env.sh`:

```bash
source lpbf/foam-env.sh
command -v laserbeamFoam
source wlam/foam-env.sh
command -v laserWireDEDFoam
```

Do not rebuild or overwrite the checked-in binaries unless that is intended.
Sluice validates and stages cases and submits the job; compile custom solvers
before submission as above.

## 4. Check the manifests

From the project checkout, validate before submitting:

```bash
sluice validate --manifest lpbf/manifest.yaml
sluice validate --manifest wlam/manifest.yaml
```

Each manifest's `resources.tasksPerNode` must match that case's
`system/decomposeParDict:numberOfSubdomains`. LPBF is set to 32 ranks and WLAM
to 2 ranks. Change both values together if the cluster allocation differs.
The LPBF mesh uses `simpleCoeffs (4 2 4)`, so changing its rank count also
requires compatible `simpleCoeffs` whose product equals the rank count.

The default mesh setup is encoded in `mesh.commands`; it runs against Sluice's
staged run copy, not the pinned source case. Do not add cleanup commands.

## 5. Produce a short run with processor folders and logs

The checked-in `manifest-short.yaml` files request a brief run and keep run
data under `.foam-runs-short/`. Make an input copy inside Sluice's ignored
run-state directory so the regular case and full simulation end times stay
untouched:

```bash
mkdir -p lpbf/.foam-runs wlam/.foam-runs
cp -a lpbf/case lpbf/.foam-runs/short-case-input
cp -a wlam/case wlam/.foam-runs/short-case-input
source lpbf/foam-env.sh
foamDictionary -entry endTime -set 2e-7 lpbf/.foam-runs/short-case-input/system/controlDict
foamDictionary -entry writeInterval -set 1e-7 lpbf/.foam-runs/short-case-input/system/controlDict
foamDictionary -entry numberOfSubdomains -set 6 lpbf/.foam-runs/short-case-input/system/decomposeParDict
foamDictionary -entry simpleCoeffs.n -set '(3 2 1)' lpbf/.foam-runs/short-case-input/system/decomposeParDict
source wlam/foam-env.sh
foamDictionary -entry endTime -set 5e-7 wlam/.foam-runs/short-case-input/system/controlDict
foamDictionary -entry writeInterval -set 2e-7 wlam/.foam-runs/short-case-input/system/controlDict
```

The short LPBF manifest uses 6 ranks and matching `simpleCoeffs (3 2 1)`,
which fits this host's six physical cores when Slurm is configured with
`--hint=nomultithread`; adjust both if the target node differs. Submit without
waiting for each job:

```bash
sluice run --manifest "$PWD/lpbf/manifest-short.yaml" --backend cli --no-watch
sluice run --manifest "$PWD/wlam/manifest-short.yaml" --backend cli --no-watch
```

The retained per-run directory under `.foam-runs-short/` contains the staged
case, `processor0/`, `processor1/`, solver and mesh logs, and Slurm output.
Find the run and its logs with:

```bash
sluice list
sluice list --db lpbf/sluice.db
sluice list --db wlam/sluice.db
sluice logs --manifest lpbf/manifest-short.yaml --latest --follow=false
sluice logs --manifest wlam/manifest-short.yaml --latest --follow=false
find lpbf/.foam-runs-short wlam/.foam-runs-short -maxdepth 3 -type d -name 'processor*'
```

## 6. Submit the full cases

Once the short runs succeed and the cluster is available, submit the regular
manifests:

```bash
sluice run --manifest lpbf/manifest.yaml --no-watch
sluice run --manifest wlam/manifest.yaml --no-watch
```

Omit `--no-watch` to follow a job interactively. Check queued/running jobs
using `sluice list` or `squeue -u "$USER"`. Use `sluice status` and `sluice
logs` for recorded jobs. A drained or unavailable partition will leave a
valid submission pending; resolve the Slurm node/partition issue before
expecting the solver to start.

Sluice does not clean the source cases or the bundled solver binaries.
Generated caches and per-run processor/log output are kept in the configured
`.foam-cache/` and `.foam-runs/` directories.
