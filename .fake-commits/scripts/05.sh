#!/usr/bin/env bash
# Generated backdated commit batch 05 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-05.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 05 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-22 17:49
NOTE="journal/2025-12-22.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-22\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
- Ran blockMesh and checked the mesh with checkMesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-22T17:49:00+0530' GIT_COMMITTER_DATE='2025-12-22T17:49:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 2/10  2025-12-22 20:20
NOTE="journal/2025-12-22.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-22\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about snappyHexMesh basics for later geometry.
- Compared k-omega SST against k-epsilon on the same mesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-22T20:20:00+0530' GIT_COMMITTER_DATE='2025-12-22T20:20:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: cleanup and formatting'

# 3/10  2026-01-22 09:39
NOTE="journal/2026-01-22.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-22\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Ran the same case in serial and with 8 MPI ranks.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-22T09:39:00+0530' GIT_COMMITTER_DATE='2026-01-22T09:39:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'solvers: SIMPLE vs SIMPLEC'

# 4/10  2026-02-19 14:02
NOTE="journal/2026-02-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about GAMG agglomeration and the coarsest level.
- Tried a pressure outlet with a fixedValue p patch.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-19T14:02:00+0530' GIT_COMMITTER_DATE='2026-02-19T14:02:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: refine mesh notes'

# 5/10  2026-03-08 07:44
NOTE="journal/2026-03-08.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-08\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at y+ estimates for the first cell layer.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-08T07:44:00+0530' GIT_COMMITTER_DATE='2026-03-08T07:44:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: cleanup and formatting'

# 6/10  2026-03-08 18:44
NOTE="journal/2026-03-08.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-08\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about boundary conditions: inletOutlet and zeroGradient.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-08T18:44:00+0530' GIT_COMMITTER_DATE='2026-03-08T18:44:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-epsilon wall functions'

# 7/10  2026-04-01 08:03
NOTE="journal/2026-04-01.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-01\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at the cell count per rank rule of thumb.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-01T08:03:00+0530' GIT_COMMITTER_DATE='2026-04-01T08:03:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 8/10  2026-04-01 12:39
NOTE="journal/2026-04-01.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-01\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about GAMG agglomeration and the coarsest level.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-01T12:39:00+0530' GIT_COMMITTER_DATE='2026-04-01T12:39:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 9/10  2026-04-22 13:37
NOTE="journal/2026-04-22.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-22\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at y+ estimates for the first cell layer.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-22T13:37:00+0530' GIT_COMMITTER_DATE='2026-04-22T13:37:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 10/10  2026-04-22 14:09
NOTE="journal/2026-04-22.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-22\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the checkMesh output: skewness, non-orthogonality, aspect ratio.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-22T14:09:00+0530' GIT_COMMITTER_DATE='2026-04-22T14:09:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: reconstructPar and compare'

touch "$MARKER"
echo "batch 05 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
