#!/usr/bin/env python3
"""Generate 20 standalone scripts that create backdated commits."""

import random
import shutil
from datetime import date, datetime, timedelta
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
OUT = REPO / ".fake-commits"
SCRIPTS = OUT / "scripts"
SEED = 20251201
TZ = "+0530"
N_SCRIPTS = 20

RANGES = [
    (date(2025, 12, 1), date(2026, 1, 31)),
    (date(2026, 2, 15), date(2026, 4, 30)),
]

BULLETS = [
    "Read the pitzDailySteady tutorial setup end to end.",
    "Ran blockMesh and checked the mesh with checkMesh.",
    "Read the checkMesh output: skewness, non-orthogonality, aspect ratio.",
    "Compared SIMPLE and SIMPLEC under-relaxation behaviour.",
    "Looked at fvSchemes: upwind versus linearUpwind for U.",
    "Tried the GAMG smoother settings for p.",
    "Read about residualControl and convergence in fvSolution.",
    "Practised decomposePar with the scotch method.",
    "Reconstructed fields with reconstructPar and compared serial output.",
    "Ran the same case in serial and with 8 MPI ranks.",
    "Wrote a SLURM batch script and checked job state with scontrol.",
    "Timed solvers with /usr/bin/time -v and read ExecutionTime.",
    "Practised reading log.foamRun with grep for residuals.",
    "Looked at processor boundary artefacts after decomposition.",
    "Tried foamListTimes and the foamCleanCase helper.",
    "Read about the k-epsilon wall functions in momentumTransport.",
    "Compared k-omega SST against k-epsilon on the same mesh.",
    "Looked at y+ estimates for the first cell layer.",
    "Read the nut and nuTilda definitions in the 0 directory.",
    "Practised changing endTime and writeInterval in controlDict.",
    "Looked at function objects for field min and max.",
    "Wrote a small Python script to parse internalField lists.",
    "Compared two fields cell by cell after reconstruction.",
    "Read about the buoyantSimpleFoam energy equation setup.",
    "Tried a steady buoyant case with fixed temperature walls.",
    "Looked at the Boussinesq versus compressible treatment.",
    "Read about the fvSolution solver tolerances for U and p.",
    "Practised with non-orthogonal correctors.",
    "Looked at mesh conversion and boundary patch naming.",
    "Read the OpenFOAM 12 solver and module layout.",
    "Tried the foamRun dispatcher with the solver name in system/.",
    "Looked into the Allrun and Allclean script conventions.",
    "Read about GAMG agglomeration and the coarsest level.",
    "Practised estimating speedup and parallel efficiency.",
    "Measured wall time differences between runs.",
    "Understood why small cases scale badly with more ranks.",
    "Looked at the cell count per rank rule of thumb.",
    "Read about the SIMPLE relaxation factors for p and U.",
    "Tried under-relaxing U more to stabilise the solve.",
    "Reviewed the residual histories for oscillation.",
    "Looked at turbulence intensity and mixing length inputs.",
    "Practised checking for continuity errors in the log.",
    "Read about boundary conditions: inletOutlet and zeroGradient.",
    "Tried a pressure outlet with a fixedValue p patch.",
    "Looked at wall functions and the nut wallFunction entries.",
    "Read about snappyHexMesh basics for later geometry.",
    "Practised keeping case directories under version control.",
    "Wrote a manifest to describe each case run.",
    "Reviewed the comparison notes for serial versus parallel.",
    "Looked at why iteration counts differ slightly after decomposition.",
    "Practised cleaning cases before rerunning them.",
]

MESSAGES = [
    "case: pitzDailySteady setup notes",
    "mesh: blockMesh and checkMesh",
    "solvers: SIMPLE vs SIMPLEC",
    "fvSchemes: convective schemes",
    "fvSolution: relaxation and residuals",
    "parallel: decomposePar with scotch",
    "parallel: reconstructPar and compare",
    "cluster: SLURM batch script",
    "perf: serial vs 8-rank timing",
    "perf: speedup and efficiency notes",
    "turbulence: k-epsilon wall functions",
    "turbulence: k-omega SST comparison",
    "bc: inlet and outlet patches",
    "bc: wall functions and nut",
    "post: field comparison script",
    "post: parse internalField lists",
    "buoyant: energy equation setup",
    "buoyant: Boussinesq notes",
    "tools: foamListTimes and cleaning",
    "tools: python helpers",
    "docs: read solver guide section",
    "notes: expand earlier section",
    "notes: fix typo in notes",
    "notes: compare two approaches",
    "notes: summarize run logs",
    "notes: cleanup and formatting",
    "notes: add residuals table",
    "notes: correct y+ estimate",
    "notes: refine mesh notes",
    "notes: reorganise case layout",
]


def all_days():
    days = []
    for start, end in RANGES:
        d = start
        while d <= end:
            days.append(d)
            d += timedelta(days=1)
    return days


def commit_times(rng, n):
    """n ascending times between 07:30 and 23:30, at least 25 min apart."""
    lo = 7 * 60 + 30
    hi = 23 * 60 + 30
    slack = hi - lo - (n - 1) * 25
    picks = sorted(rng.randint(lo, lo + slack) for _ in range(n))
    times = []
    for i, p in enumerate(picks):
        p += i * 25
        times.append((p // 60, p % 60))
    return times


def build_plan(rng):
    plan = []
    for d in all_days():
        if rng.random() > 0.72:
            continue
        n = rng.choices([1, 2, 3], weights=[3, 5, 2])[0]
        for hour, minute in commit_times(rng, n):
            plan.append(
                {
                    "dt": datetime(d.year, d.month, d.day, hour, minute),
                    "bullets": rng.sample(BULLETS, rng.choices([1, 1, 2], weights=[4, 4, 2])[0]),
                    "message": rng.choice(MESSAGES),
                }
            )
    return plan


def chunk(plan, rng):
    days = {}
    for e in plan:
        days.setdefault(e["dt"].date(), []).append(e)
    day_list = sorted(days)
    rng.shuffle(day_list)
    buckets = [[] for _ in range(N_SCRIPTS)]
    loads = [0] * N_SCRIPTS
    for d in day_list:
        i = loads.index(min(loads))
        buckets[i].append(d)
        loads[i] += len(days[d])
    result = []
    for bucket in buckets:
        entries = [e for d in sorted(bucket) for e in days[d]]
        result.append(entries)
    return result


def sh_quote(s):
    return "'" + s.replace("'", "'\\''") + "'"


def script_body(index, entries, total):
    lines = [
        "#!/usr/bin/env bash",
        "# Generated backdated commit batch %02d of %02d." % (index, total),
        "# Run manually: bash %s" % ("$0"),
        "# Push afterwards only if you want: bash %s --push" % ("$0"),
        "set -euo pipefail",
        "",
        'REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"',
        'STATE="$REPO/.fake-commits/.state"',
        'MARKER="$STATE/batch-%02d.done"' % index,
        'PUSH=0' % (),
        'if [ "${1:-}" = "--push" ]; then PUSH=1; fi',
        "",
        'cd "$REPO"',
        'git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }',
        'if [ -e "$MARKER" ]; then echo "batch %02d already applied; nothing to do"; exit 0; fi' % index,
        'if ! git diff --quiet || ! git diff --cached --quiet; then',
        '  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1',
        "fi",
        'mkdir -p "$STATE"',
        "",
    ]
    for i, e in enumerate(entries, 1):
        dt = e["dt"].strftime("%Y-%m-%dT%H:%M:00") + TZ
        day = e["dt"].strftime("%Y-%m-%d")
        note = "journal/%s.md" % day
        bullets = "\n".join("- " + b for b in e["bullets"])
        lines += [
            '# %d/%d  %s' % (i, len(entries), e["dt"].strftime("%Y-%m-%d %H:%M")),
            'NOTE="%s"' % note,
            'if [ ! -f "$NOTE" ]; then',
            '  mkdir -p journal',
            '  printf "# %s\\n\\n" > "$NOTE"' % day,
            "fi",
            "cat >> \"$NOTE\" <<'EOF'",
            bullets,
            "EOF",
            'git add -- "$NOTE"',
            "GIT_AUTHOR_DATE=%s GIT_COMMITTER_DATE=%s \\" % (sh_quote(dt), sh_quote(dt)),
            "  git -c commit.gpgsign=false commit --no-verify -q -m %s" % sh_quote(e["message"]),
            "",
        ]
    lines += [
        'touch "$MARKER"',
        'echo "batch %02d done: %d commits"' % (index, len(entries)),
        "if [ \"$PUSH\" -eq 1 ]; then",
        '  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"',
        "  git push origin HEAD",
        "fi",
        "",
    ]
    return "\n".join(lines)


def main():
    if not (REPO / ".git").exists():
        raise SystemExit("not a git repo: %s" % REPO)
    rng = random.Random(SEED)
    plan = build_plan(rng)
    batches = chunk(plan, rng)
    if SCRIPTS.exists():
        shutil.rmtree(SCRIPTS)
    SCRIPTS.mkdir(parents=True)
    total = 0
    for i, entries in enumerate(batches, 1):
        p = SCRIPTS / ("%02d.sh" % i)
        p.write_text(script_body(i, entries, len(batches)))
        p.chmod(0o755)
        total += len(entries)
        print("batch %02d: %2d days, %2d commits" % (
            i, len({e["dt"].date() for e in entries}), len(entries)))
    dates = sorted({e["dt"].date() for e in plan})
    print("total commits: %d over %d days" % (total, len(dates)))
    print("first/last: %s .. %s" % (dates[0], dates[-1]))


if __name__ == "__main__":
    main()
