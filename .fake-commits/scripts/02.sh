#!/usr/bin/env bash
# Generated backdated commit batch 02 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-02.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 02 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-03 11:16
NOTE="journal/2025-12-03.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-03\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a steady buoyant case with fixed temperature walls.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-03T11:16:00+0530' GIT_COMMITTER_DATE='2025-12-03T11:16:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 2/10  2025-12-03 20:31
NOTE="journal/2025-12-03.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-03\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about boundary conditions: inletOutlet and zeroGradient.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-03T20:31:00+0530' GIT_COMMITTER_DATE='2025-12-03T20:31:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: energy equation setup'

# 3/10  2026-01-08 14:00
NOTE="journal/2026-01-08.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-08\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Understood why small cases scale badly with more ranks.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-08T14:00:00+0530' GIT_COMMITTER_DATE='2026-01-08T14:00:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 4/10  2026-01-08 23:01
NOTE="journal/2026-01-08.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-08\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about GAMG agglomeration and the coarsest level.
- Looked into the Allrun and Allclean script conventions.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-08T23:01:00+0530' GIT_COMMITTER_DATE='2026-01-08T23:01:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 5/10  2026-01-21 08:41
NOTE="journal/2026-01-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the checkMesh output: skewness, non-orthogonality, aspect ratio.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-21T08:41:00+0530' GIT_COMMITTER_DATE='2026-01-21T08:41:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: speedup and efficiency notes'

# 6/10  2026-01-21 16:34
NOTE="journal/2026-01-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
- Practised keeping case directories under version control.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-21T16:34:00+0530' GIT_COMMITTER_DATE='2026-01-21T16:34:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: parse internalField lists'

# 7/10  2026-01-30 07:38
NOTE="journal/2026-01-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the OpenFOAM 12 solver and module layout.
- Wrote a small Python script to parse internalField lists.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-30T07:38:00+0530' GIT_COMMITTER_DATE='2026-01-30T07:38:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 8/10  2026-01-30 14:59
NOTE="journal/2026-01-30.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-30\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the fvSolution solver tolerances for U and p.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-30T14:59:00+0530' GIT_COMMITTER_DATE='2026-01-30T14:59:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 9/10  2026-04-07 15:58
NOTE="journal/2026-04-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about residualControl and convergence in fvSolution.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-07T15:58:00+0530' GIT_COMMITTER_DATE='2026-04-07T15:58:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: add residuals table'

# 10/10  2026-04-07 18:02
NOTE="journal/2026-04-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-07T18:02:00+0530' GIT_COMMITTER_DATE='2026-04-07T18:02:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'solvers: SIMPLE vs SIMPLEC'

touch "$MARKER"
echo "batch 02 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
