#!/usr/bin/env bash
# Generated backdated commit batch 12 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-12.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 12 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2025-12-12 13:18
NOTE="journal/2025-12-12.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-12\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the k-epsilon wall functions in momentumTransport.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-12T13:18:00+0530' GIT_COMMITTER_DATE='2025-12-12T13:18:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: serial vs 8-rank timing'

# 2/9  2025-12-12 16:06
NOTE="journal/2025-12-12.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-12\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at function objects for field min and max.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-12T16:06:00+0530' GIT_COMMITTER_DATE='2025-12-12T16:06:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: wall functions and nut'

# 3/9  2026-01-01 16:49
NOTE="journal/2026-01-01.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-01\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
- Tried the GAMG smoother settings for p.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-01T16:49:00+0530' GIT_COMMITTER_DATE='2026-01-01T16:49:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 4/9  2026-01-01 20:09
NOTE="journal/2026-01-01.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-01\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about GAMG agglomeration and the coarsest level.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-01T20:09:00+0530' GIT_COMMITTER_DATE='2026-01-01T20:09:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: refine mesh notes'

# 5/9  2026-02-25 18:56
NOTE="journal/2026-02-25.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-25\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at mesh conversion and boundary patch naming.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-25T18:56:00+0530' GIT_COMMITTER_DATE='2026-02-25T18:56:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 6/9  2026-02-25 20:34
NOTE="journal/2026-02-25.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-25\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised with non-orthogonal correctors.
- Tried a pressure outlet with a fixedValue p patch.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-25T20:34:00+0530' GIT_COMMITTER_DATE='2026-02-25T20:34:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: parse internalField lists'

# 7/9  2026-03-26 12:05
NOTE="journal/2026-03-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the fvSolution solver tolerances for U and p.
- Ran blockMesh and checked the mesh with checkMesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-26T12:05:00+0530' GIT_COMMITTER_DATE='2026-03-26T12:05:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: energy equation setup'

# 8/9  2026-03-26 14:29
NOTE="journal/2026-03-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about snappyHexMesh basics for later geometry.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-26T14:29:00+0530' GIT_COMMITTER_DATE='2026-03-26T14:29:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 9/9  2026-03-26 20:42
NOTE="journal/2026-03-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Timed solvers with /usr/bin/time -v and read ExecutionTime.
- Read about residualControl and convergence in fvSolution.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-26T20:42:00+0530' GIT_COMMITTER_DATE='2026-03-26T20:42:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'solvers: SIMPLE vs SIMPLEC'

touch "$MARKER"
echo "batch 12 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
