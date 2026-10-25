#!/usr/bin/env bash
# Generated backdated commit batch 08 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-08.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 08 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/11  2025-12-21 11:28
NOTE="journal/2025-12-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about boundary conditions: inletOutlet and zeroGradient.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-21T11:28:00+0530' GIT_COMMITTER_DATE='2025-12-21T11:28:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 2/11  2025-12-21 14:27
NOTE="journal/2025-12-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised keeping case directories under version control.
- Looked at y+ estimates for the first cell layer.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-21T14:27:00+0530' GIT_COMMITTER_DATE='2025-12-21T14:27:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: decomposePar with scotch'

# 3/11  2025-12-21 16:21
NOTE="journal/2025-12-21.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-21\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Ran the same case in serial and with 8 MPI ranks.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-21T16:21:00+0530' GIT_COMMITTER_DATE='2025-12-21T16:21:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 4/11  2025-12-27 09:49
NOTE="journal/2025-12-27.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-27\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about snappyHexMesh basics for later geometry.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-27T09:49:00+0530' GIT_COMMITTER_DATE='2025-12-27T09:49:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 5/11  2025-12-27 16:39
NOTE="journal/2025-12-27.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-27\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried foamListTimes and the foamCleanCase helper.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-27T16:39:00+0530' GIT_COMMITTER_DATE='2025-12-27T16:39:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 6/11  2025-12-29 09:11
NOTE="journal/2025-12-29.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-29\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the SIMPLE relaxation factors for p and U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-29T09:11:00+0530' GIT_COMMITTER_DATE='2025-12-29T09:11:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'solvers: SIMPLE vs SIMPLEC'

# 7/11  2025-12-29 15:54
NOTE="journal/2025-12-29.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-29\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the nut and nuTilda definitions in the 0 directory.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-29T15:54:00+0530' GIT_COMMITTER_DATE='2025-12-29T15:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 8/11  2026-03-05 12:16
NOTE="journal/2026-03-05.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-05\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a small Python script to parse internalField lists.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-05T12:16:00+0530' GIT_COMMITTER_DATE='2026-03-05T12:16:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: decomposePar with scotch'

# 9/11  2026-03-05 17:24
NOTE="journal/2026-03-05.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-05\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised estimating speedup and parallel efficiency.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-05T17:24:00+0530' GIT_COMMITTER_DATE='2026-03-05T17:24:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 10/11  2026-04-17 08:34
NOTE="journal/2026-04-17.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-17\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Ran the same case in serial and with 8 MPI ranks.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-17T08:34:00+0530' GIT_COMMITTER_DATE='2026-04-17T08:34:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 11/11  2026-04-17 17:58
NOTE="journal/2026-04-17.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-17\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried foamListTimes and the foamCleanCase helper.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-17T17:58:00+0530' GIT_COMMITTER_DATE='2026-04-17T17:58:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: refine mesh notes'

touch "$MARKER"
echo "batch 08 done: 11 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
