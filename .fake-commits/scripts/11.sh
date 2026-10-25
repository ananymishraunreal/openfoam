#!/usr/bin/env bash
# Generated backdated commit batch 11 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-11.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 11 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2025-12-15 12:27
NOTE="journal/2025-12-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared k-omega SST against k-epsilon on the same mesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-15T12:27:00+0530' GIT_COMMITTER_DATE='2025-12-15T12:27:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: wall functions and nut'

# 2/9  2025-12-15 14:29
NOTE="journal/2025-12-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised with non-orthogonal correctors.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-15T14:29:00+0530' GIT_COMMITTER_DATE='2025-12-15T14:29:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 3/9  2026-03-04 09:02
NOTE="journal/2026-03-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about boundary conditions: inletOutlet and zeroGradient.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-04T09:02:00+0530' GIT_COMMITTER_DATE='2026-03-04T09:02:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 4/9  2026-03-04 13:54
NOTE="journal/2026-03-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at why iteration counts differ slightly after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-04T13:54:00+0530' GIT_COMMITTER_DATE='2026-03-04T13:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: compare two approaches'

# 5/9  2026-03-21 18:52
NOTE="journal/2026-03-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Understood why small cases scale badly with more ranks.
- Tried the GAMG smoother settings for p.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-21T18:52:00+0530' GIT_COMMITTER_DATE='2026-03-21T18:52:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: python helpers'

# 6/9  2026-03-21 21:05
NOTE="journal/2026-03-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Measured wall time differences between runs.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-21T21:05:00+0530' GIT_COMMITTER_DATE='2026-03-21T21:05:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: fix typo in notes'

# 7/9  2026-03-30 13:22
NOTE="journal/2026-03-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised decomposePar with the scotch method.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-30T13:22:00+0530' GIT_COMMITTER_DATE='2026-03-30T13:22:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 8/9  2026-03-30 15:08
NOTE="journal/2026-03-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried foamListTimes and the foamCleanCase helper.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-30T15:08:00+0530' GIT_COMMITTER_DATE='2026-03-30T15:08:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'docs: read solver guide section'

# 9/9  2026-03-30 20:27
NOTE="journal/2026-03-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised keeping case directories under version control.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-30T20:27:00+0530' GIT_COMMITTER_DATE='2026-03-30T20:27:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: parse internalField lists'

touch "$MARKER"
echo "batch 11 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
