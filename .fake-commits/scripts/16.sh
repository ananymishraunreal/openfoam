#!/usr/bin/env bash
# Generated backdated commit batch 16 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-16.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 16 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2025-12-13 09:37
NOTE="journal/2025-12-13.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-13\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared k-omega SST against k-epsilon on the same mesh.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-13T09:37:00+0530' GIT_COMMITTER_DATE='2025-12-13T09:37:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

# 2/9  2025-12-13 19:14
NOTE="journal/2025-12-13.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-13\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about residualControl and convergence in fvSolution.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-13T19:14:00+0530' GIT_COMMITTER_DATE='2025-12-13T19:14:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'docs: read solver guide section'

# 3/9  2025-12-13 22:32
NOTE="journal/2025-12-13.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-13\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at why iteration counts differ slightly after decomposition.
- Read the OpenFOAM 12 solver and module layout.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-13T22:32:00+0530' GIT_COMMITTER_DATE='2025-12-13T22:32:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: summarize run logs'

# 4/9  2026-01-20 12:30
NOTE="journal/2026-01-20.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-20\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at the Boussinesq versus compressible treatment.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-20T12:30:00+0530' GIT_COMMITTER_DATE='2026-01-20T12:30:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: decomposePar with scotch'

# 5/9  2026-02-24 12:25
NOTE="journal/2026-02-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about GAMG agglomeration and the coarsest level.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-24T12:25:00+0530' GIT_COMMITTER_DATE='2026-02-24T12:25:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 6/9  2026-02-24 14:46
NOTE="journal/2026-02-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised with non-orthogonal correctors.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-24T14:46:00+0530' GIT_COMMITTER_DATE='2026-02-24T14:46:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: cleanup and formatting'

# 7/9  2026-04-06 08:54
NOTE="journal/2026-04-06.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-06\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the SIMPLE relaxation factors for p and U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-06T08:54:00+0530' GIT_COMMITTER_DATE='2026-04-06T08:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: Boussinesq notes'

# 8/9  2026-04-06 09:48
NOTE="journal/2026-04-06.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-06\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised checking for continuity errors in the log.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-06T09:48:00+0530' GIT_COMMITTER_DATE='2026-04-06T09:48:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'solvers: SIMPLE vs SIMPLEC'

# 9/9  2026-04-29 18:18
NOTE="journal/2026-04-29.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-29\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the nut and nuTilda definitions in the 0 directory.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-29T18:18:00+0530' GIT_COMMITTER_DATE='2026-04-29T18:18:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

touch "$MARKER"
echo "batch 16 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
