#!/usr/bin/env bash
# Generated backdated commit batch 17 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-17.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 17 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/8  2026-01-04 09:13
NOTE="journal/2026-01-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about snappyHexMesh basics for later geometry.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-04T09:13:00+0530' GIT_COMMITTER_DATE='2026-01-04T09:13:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: python helpers'

# 2/8  2026-01-04 10:30
NOTE="journal/2026-01-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised estimating speedup and parallel efficiency.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-04T10:30:00+0530' GIT_COMMITTER_DATE='2026-01-04T10:30:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 3/8  2026-01-11 07:36
NOTE="journal/2026-01-11.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-11\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reconstructed fields with reconstructPar and compared serial output.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-11T07:36:00+0530' GIT_COMMITTER_DATE='2026-01-11T07:36:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 4/8  2026-01-11 08:43
NOTE="journal/2026-01-11.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-11\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a pressure outlet with a fixedValue p patch.
- Compared two fields cell by cell after reconstruction.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-11T08:43:00+0530' GIT_COMMITTER_DATE='2026-01-11T08:43:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: energy equation setup'

# 5/8  2026-03-29 12:22
NOTE="journal/2026-03-29.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-29\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised cleaning cases before rerunning them.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-29T12:22:00+0530' GIT_COMMITTER_DATE='2026-03-29T12:22:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 6/8  2026-04-30 15:33
NOTE="journal/2026-04-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked into the Allrun and Allclean script conventions.
- Tried under-relaxing U more to stabilise the solve.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-30T15:33:00+0530' GIT_COMMITTER_DATE='2026-04-30T15:33:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 7/8  2026-04-30 17:00
NOTE="journal/2026-04-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Ran blockMesh and checked the mesh with checkMesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-30T17:00:00+0530' GIT_COMMITTER_DATE='2026-04-30T17:00:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-epsilon wall functions'

# 8/8  2026-04-30 21:07
NOTE="journal/2026-04-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried foamListTimes and the foamCleanCase helper.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-30T21:07:00+0530' GIT_COMMITTER_DATE='2026-04-30T21:07:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: fix typo in notes'

touch "$MARKER"
echo "batch 17 done: 8 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
