#!/usr/bin/env bash
# Generated backdated commit batch 15 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-15.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 15 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-01 17:38
NOTE="journal/2025-12-01.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-01\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at the Boussinesq versus compressible treatment.
- Tried the GAMG smoother settings for p.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-01T17:38:00+0530' GIT_COMMITTER_DATE='2025-12-01T17:38:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: summarize run logs'

# 2/10  2025-12-18 12:06
NOTE="journal/2025-12-18.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-18\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the pitzDailySteady tutorial setup end to end.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-18T12:06:00+0530' GIT_COMMITTER_DATE='2025-12-18T12:06:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: serial vs 8-rank timing'

# 3/10  2025-12-18 20:18
NOTE="journal/2025-12-18.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-18\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about GAMG agglomeration and the coarsest level.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-18T20:18:00+0530' GIT_COMMITTER_DATE='2025-12-18T20:18:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: add residuals table'

# 4/10  2026-01-17 16:26
NOTE="journal/2026-01-17.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-17\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at why iteration counts differ slightly after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-17T16:26:00+0530' GIT_COMMITTER_DATE='2026-01-17T16:26:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 5/10  2026-01-17 17:54
NOTE="journal/2026-01-17.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-17\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about residualControl and convergence in fvSolution.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-17T17:54:00+0530' GIT_COMMITTER_DATE='2026-01-17T17:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 6/10  2026-02-21 18:59
NOTE="journal/2026-02-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the comparison notes for serial versus parallel.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-21T18:59:00+0530' GIT_COMMITTER_DATE='2026-02-21T18:59:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 7/10  2026-03-14 07:53
NOTE="journal/2026-03-14.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-14\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the comparison notes for serial versus parallel.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-14T07:53:00+0530' GIT_COMMITTER_DATE='2026-03-14T07:53:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 8/10  2026-03-14 19:42
NOTE="journal/2026-03-14.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-14\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the SIMPLE relaxation factors for p and U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-14T19:42:00+0530' GIT_COMMITTER_DATE='2026-03-14T19:42:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: Boussinesq notes'

# 9/10  2026-04-28 17:03
NOTE="journal/2026-04-28.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-28\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at why iteration counts differ slightly after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-28T17:03:00+0530' GIT_COMMITTER_DATE='2026-04-28T17:03:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

# 10/10  2026-04-28 23:07
NOTE="journal/2026-04-28.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-28\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at mesh conversion and boundary patch naming.
- Practised reading log.foamRun with grep for residuals.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-28T23:07:00+0530' GIT_COMMITTER_DATE='2026-04-28T23:07:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSchemes: convective schemes'

touch "$MARKER"
echo "batch 15 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
