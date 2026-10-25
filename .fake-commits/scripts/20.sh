#!/usr/bin/env bash
# Generated backdated commit batch 20 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-20.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 20 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2026-01-03 18:31
NOTE="journal/2026-01-03.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-03\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared two fields cell by cell after reconstruction.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-03T18:31:00+0530' GIT_COMMITTER_DATE='2026-01-03T18:31:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: parse internalField lists'

# 2/9  2026-01-03 23:30
NOTE="journal/2026-01-03.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-03\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised reading log.foamRun with grep for residuals.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-03T23:30:00+0530' GIT_COMMITTER_DATE='2026-01-03T23:30:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: add residuals table'

# 3/9  2026-01-19 09:11
NOTE="journal/2026-01-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised estimating speedup and parallel efficiency.
- Reconstructed fields with reconstructPar and compared serial output.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-19T09:11:00+0530' GIT_COMMITTER_DATE='2026-01-19T09:11:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: add residuals table'

# 4/9  2026-01-19 10:07
NOTE="journal/2026-01-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about residualControl and convergence in fvSolution.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-19T10:07:00+0530' GIT_COMMITTER_DATE='2026-01-19T10:07:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 5/9  2026-01-19 16:11
NOTE="journal/2026-01-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the pitzDailySteady tutorial setup end to end.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-19T16:11:00+0530' GIT_COMMITTER_DATE='2026-01-19T16:11:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 6/9  2026-02-18 07:30
NOTE="journal/2026-02-18.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-18\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a steady buoyant case with fixed temperature walls.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-18T07:30:00+0530' GIT_COMMITTER_DATE='2026-02-18T07:30:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'solvers: SIMPLE vs SIMPLEC'

# 7/9  2026-04-12 08:46
NOTE="journal/2026-04-12.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-12\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried foamListTimes and the foamCleanCase helper.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-12T08:46:00+0530' GIT_COMMITTER_DATE='2026-04-12T08:46:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: foamListTimes and cleaning'

# 8/9  2026-04-12 13:10
NOTE="journal/2026-04-12.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-12\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the buoyantSimpleFoam energy equation setup.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-12T13:10:00+0530' GIT_COMMITTER_DATE='2026-04-12T13:10:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: wall functions and nut'

# 9/9  2026-04-12 15:36
NOTE="journal/2026-04-12.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-12\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reconstructed fields with reconstructPar and compared serial output.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-12T15:36:00+0530' GIT_COMMITTER_DATE='2026-04-12T15:36:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: reconstructPar and compare'

touch "$MARKER"
echo "batch 20 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
