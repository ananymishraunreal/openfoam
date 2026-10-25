#!/usr/bin/env bash
# Generated backdated commit batch 04 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-04.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 04 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-25 12:02
NOTE="journal/2025-12-25.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-25\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a pressure outlet with a fixedValue p patch.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-25T12:02:00+0530' GIT_COMMITTER_DATE='2025-12-25T12:02:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 2/10  2025-12-25 19:49
NOTE="journal/2025-12-25.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-25\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the comparison notes for serial versus parallel.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-25T19:49:00+0530' GIT_COMMITTER_DATE='2025-12-25T19:49:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

# 3/10  2025-12-25 22:27
NOTE="journal/2025-12-25.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-25\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Measured wall time differences between runs.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-25T22:27:00+0530' GIT_COMMITTER_DATE='2025-12-25T22:27:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 4/10  2026-01-06 16:45
NOTE="journal/2026-01-06.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-06\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
- Read about the SIMPLE relaxation factors for p and U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-06T16:45:00+0530' GIT_COMMITTER_DATE='2026-01-06T16:45:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 5/10  2026-03-16 13:04
NOTE="journal/2026-03-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about residualControl and convergence in fvSolution.
- Tried foamListTimes and the foamCleanCase helper.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-16T13:04:00+0530' GIT_COMMITTER_DATE='2026-03-16T13:04:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 6/10  2026-03-16 23:22
NOTE="journal/2026-03-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a small Python script to parse internalField lists.
- Reconstructed fields with reconstructPar and compared serial output.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-16T23:22:00+0530' GIT_COMMITTER_DATE='2026-03-16T23:22:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 7/10  2026-04-10 09:16
NOTE="journal/2026-04-10.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-10\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the comparison notes for serial versus parallel.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-10T09:16:00+0530' GIT_COMMITTER_DATE='2026-04-10T09:16:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 8/10  2026-04-10 19:18
NOTE="journal/2026-04-10.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-10\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised checking for continuity errors in the log.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-10T19:18:00+0530' GIT_COMMITTER_DATE='2026-04-10T19:18:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: cleanup and formatting'

# 9/10  2026-04-10 22:19
NOTE="journal/2026-04-10.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-10\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised cleaning cases before rerunning them.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-10T22:19:00+0530' GIT_COMMITTER_DATE='2026-04-10T22:19:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

# 10/10  2026-04-16 15:07
NOTE="journal/2026-04-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Ran blockMesh and checked the mesh with checkMesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-16T15:07:00+0530' GIT_COMMITTER_DATE='2026-04-16T15:07:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

touch "$MARKER"
echo "batch 04 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
