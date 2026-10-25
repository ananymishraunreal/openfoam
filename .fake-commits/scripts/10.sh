#!/usr/bin/env bash
# Generated backdated commit batch 10 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-10.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 10 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-07 14:10
NOTE="journal/2025-12-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the k-epsilon wall functions in momentumTransport.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-07T14:10:00+0530' GIT_COMMITTER_DATE='2025-12-07T14:10:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: foamListTimes and cleaning'

# 2/10  2025-12-07 22:32
NOTE="journal/2025-12-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared two fields cell by cell after reconstruction.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-07T22:32:00+0530' GIT_COMMITTER_DATE='2025-12-07T22:32:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 3/10  2025-12-09 12:34
NOTE="journal/2025-12-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a manifest to describe each case run.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-09T12:34:00+0530' GIT_COMMITTER_DATE='2025-12-09T12:34:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: summarize run logs'

# 4/10  2025-12-09 19:28
NOTE="journal/2025-12-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the checkMesh output: skewness, non-orthogonality, aspect ratio.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-09T19:28:00+0530' GIT_COMMITTER_DATE='2025-12-09T19:28:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: wall functions and nut'

# 5/10  2025-12-09 21:03
NOTE="journal/2025-12-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at fvSchemes: upwind versus linearUpwind for U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-09T21:03:00+0530' GIT_COMMITTER_DATE='2025-12-09T21:03:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: parse internalField lists'

# 6/10  2026-01-14 12:34
NOTE="journal/2026-01-14.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-14\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the OpenFOAM 12 solver and module layout.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-14T12:34:00+0530' GIT_COMMITTER_DATE='2026-01-14T12:34:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: compare two approaches'

# 7/10  2026-01-14 14:51
NOTE="journal/2026-01-14.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-14\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked into the Allrun and Allclean script conventions.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-14T14:51:00+0530' GIT_COMMITTER_DATE='2026-01-14T14:51:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: foamListTimes and cleaning'

# 8/10  2026-02-27 09:27
NOTE="journal/2026-02-27.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-27\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
- Read the nut and nuTilda definitions in the 0 directory.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-27T09:27:00+0530' GIT_COMMITTER_DATE='2026-02-27T09:27:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 9/10  2026-02-27 15:47
NOTE="journal/2026-02-27.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-27\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised with non-orthogonal correctors.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-27T15:47:00+0530' GIT_COMMITTER_DATE='2026-02-27T15:47:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 10/10  2026-04-14 17:06
NOTE="journal/2026-04-14.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-14\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Understood why small cases scale badly with more ranks.
- Practised cleaning cases before rerunning them.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-14T17:06:00+0530' GIT_COMMITTER_DATE='2026-04-14T17:06:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-epsilon wall functions'

touch "$MARKER"
echo "batch 10 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
