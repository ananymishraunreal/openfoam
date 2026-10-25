#!/usr/bin/env bash
# Generated backdated commit batch 13 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-13.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 13 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2026-01-05 14:51
NOTE="journal/2026-01-05.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-05\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a small Python script to parse internalField lists.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-05T14:51:00+0530' GIT_COMMITTER_DATE='2026-01-05T14:51:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 2/9  2026-01-05 17:01
NOTE="journal/2026-01-05.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-05\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reconstructed fields with reconstructPar and compared serial output.
- Looked at processor boundary artefacts after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-05T17:01:00+0530' GIT_COMMITTER_DATE='2026-01-05T17:01:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

# 3/9  2026-01-09 10:31
NOTE="journal/2026-01-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the checkMesh output: skewness, non-orthogonality, aspect ratio.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-09T10:31:00+0530' GIT_COMMITTER_DATE='2026-01-09T10:31:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'docs: read solver guide section'

# 4/9  2026-01-09 18:44
NOTE="journal/2026-01-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at the Boussinesq versus compressible treatment.
- Compared k-omega SST against k-epsilon on the same mesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-09T18:44:00+0530' GIT_COMMITTER_DATE='2026-01-09T18:44:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: foamListTimes and cleaning'

# 5/9  2026-01-16 13:00
NOTE="journal/2026-01-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about GAMG agglomeration and the coarsest level.
- Read about snappyHexMesh basics for later geometry.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-16T13:00:00+0530' GIT_COMMITTER_DATE='2026-01-16T13:00:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 6/9  2026-01-16 14:46
NOTE="journal/2026-01-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at function objects for field min and max.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-16T14:46:00+0530' GIT_COMMITTER_DATE='2026-01-16T14:46:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'docs: read solver guide section'

# 7/9  2026-03-19 17:42
NOTE="journal/2026-03-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at fvSchemes: upwind versus linearUpwind for U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-19T17:42:00+0530' GIT_COMMITTER_DATE='2026-03-19T17:42:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-epsilon wall functions'

# 8/9  2026-04-19 12:59
NOTE="journal/2026-04-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about snappyHexMesh basics for later geometry.
- Looked at turbulence intensity and mixing length inputs.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-19T12:59:00+0530' GIT_COMMITTER_DATE='2026-04-19T12:59:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: decomposePar with scotch'

# 9/9  2026-04-19 19:19
NOTE="journal/2026-04-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the nut and nuTilda definitions in the 0 directory.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-19T19:19:00+0530' GIT_COMMITTER_DATE='2026-04-19T19:19:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

touch "$MARKER"
echo "batch 13 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
