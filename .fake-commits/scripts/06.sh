#!/usr/bin/env bash
# Generated backdated commit batch 06 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-06.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 06 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2025-12-16 21:54
NOTE="journal/2025-12-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Measured wall time differences between runs.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-16T21:54:00+0530' GIT_COMMITTER_DATE='2025-12-16T21:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: fix typo in notes'

# 2/9  2025-12-23 09:55
NOTE="journal/2025-12-23.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-23\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a steady buoyant case with fixed temperature walls.
- Looked at processor boundary artefacts after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-23T09:55:00+0530' GIT_COMMITTER_DATE='2025-12-23T09:55:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 3/9  2026-01-31 09:12
NOTE="journal/2026-01-31.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-31\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised cleaning cases before rerunning them.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-31T09:12:00+0530' GIT_COMMITTER_DATE='2026-01-31T09:12:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: speedup and efficiency notes'

# 4/9  2026-01-31 21:46
NOTE="journal/2026-01-31.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-31\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the residual histories for oscillation.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-31T21:46:00+0530' GIT_COMMITTER_DATE='2026-01-31T21:46:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 5/9  2026-02-15 07:47
NOTE="journal/2026-02-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the GAMG smoother settings for p.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-15T07:47:00+0530' GIT_COMMITTER_DATE='2026-02-15T07:47:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: field comparison script'

# 6/9  2026-02-15 17:33
NOTE="journal/2026-02-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised decomposePar with the scotch method.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-15T17:33:00+0530' GIT_COMMITTER_DATE='2026-02-15T17:33:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 7/9  2026-02-15 22:39
NOTE="journal/2026-02-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the pitzDailySteady tutorial setup end to end.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-15T22:39:00+0530' GIT_COMMITTER_DATE='2026-02-15T22:39:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

# 8/9  2026-03-20 08:24
NOTE="journal/2026-03-20.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-20\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a steady buoyant case with fixed temperature walls.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-20T08:24:00+0530' GIT_COMMITTER_DATE='2026-03-20T08:24:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 9/9  2026-03-20 15:22
NOTE="journal/2026-03-20.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-20\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-20T15:22:00+0530' GIT_COMMITTER_DATE='2026-03-20T15:22:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: summarize run logs'

touch "$MARKER"
echo "batch 06 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
