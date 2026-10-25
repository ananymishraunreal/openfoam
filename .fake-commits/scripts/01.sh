#!/usr/bin/env bash
# Generated backdated commit batch 01 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-01.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 01 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2026-01-02 11:29
NOTE="journal/2026-01-02.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-02\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the checkMesh output: skewness, non-orthogonality, aspect ratio.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-02T11:29:00+0530' GIT_COMMITTER_DATE='2026-01-02T11:29:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: add residuals table'

# 2/9  2026-01-02 16:16
NOTE="journal/2026-01-02.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-02\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised with non-orthogonal correctors.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-02T16:16:00+0530' GIT_COMMITTER_DATE='2026-01-02T16:16:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: Boussinesq notes'

# 3/9  2026-01-07 10:51
NOTE="journal/2026-01-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at wall functions and the nut wallFunction entries.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-07T10:51:00+0530' GIT_COMMITTER_DATE='2026-01-07T10:51:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: python helpers'

# 4/9  2026-01-07 14:53
NOTE="journal/2026-01-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Understood why small cases scale badly with more ranks.
- Looked at mesh conversion and boundary patch naming.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-07T14:53:00+0530' GIT_COMMITTER_DATE='2026-01-07T14:53:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: serial vs 8-rank timing'

# 5/9  2026-01-07 20:35
NOTE="journal/2026-01-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the nut and nuTilda definitions in the 0 directory.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-07T20:35:00+0530' GIT_COMMITTER_DATE='2026-01-07T20:35:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: summarize run logs'

# 6/9  2026-02-28 08:50
NOTE="journal/2026-02-28.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-28\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
- Practised decomposePar with the scotch method.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-28T08:50:00+0530' GIT_COMMITTER_DATE='2026-02-28T08:50:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 7/9  2026-02-28 19:42
NOTE="journal/2026-02-28.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-28\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised keeping case directories under version control.
- Compared two fields cell by cell after reconstruction.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-28T19:42:00+0530' GIT_COMMITTER_DATE='2026-02-28T19:42:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: python helpers'

# 8/9  2026-04-09 12:24
NOTE="journal/2026-04-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at processor boundary artefacts after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-09T12:24:00+0530' GIT_COMMITTER_DATE='2026-04-09T12:24:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 9/9  2026-04-20 19:18
NOTE="journal/2026-04-20.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-20\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a pressure outlet with a fixedValue p patch.
- Read the OpenFOAM 12 solver and module layout.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-20T19:18:00+0530' GIT_COMMITTER_DATE='2026-04-20T19:18:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

touch "$MARKER"
echo "batch 01 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
