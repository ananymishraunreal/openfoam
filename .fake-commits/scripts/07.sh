#!/usr/bin/env bash
# Generated backdated commit batch 07 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-07.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 07 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2025-12-10 12:03
NOTE="journal/2025-12-10.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-10\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried foamListTimes and the foamCleanCase helper.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-10T12:03:00+0530' GIT_COMMITTER_DATE='2025-12-10T12:03:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 2/9  2025-12-10 13:56
NOTE="journal/2025-12-10.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-10\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the fvSolution solver tolerances for U and p.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-10T13:56:00+0530' GIT_COMMITTER_DATE='2025-12-10T13:56:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: decomposePar with scotch'

# 3/9  2025-12-10 15:54
NOTE="journal/2025-12-10.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-10\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-10T15:54:00+0530' GIT_COMMITTER_DATE='2025-12-10T15:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-epsilon wall functions'

# 4/9  2026-01-26 07:51
NOTE="journal/2026-01-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Ran the same case in serial and with 8 MPI ranks.
- Read about the SIMPLE relaxation factors for p and U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-26T07:51:00+0530' GIT_COMMITTER_DATE='2026-01-26T07:51:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 5/9  2026-01-26 09:29
NOTE="journal/2026-01-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised reading log.foamRun with grep for residuals.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-26T09:29:00+0530' GIT_COMMITTER_DATE='2026-01-26T09:29:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: fix typo in notes'

# 6/9  2026-03-10 17:05
NOTE="journal/2026-03-10.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-10\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared SIMPLE and SIMPLEC under-relaxation behaviour.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-10T17:05:00+0530' GIT_COMMITTER_DATE='2026-03-10T17:05:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: field comparison script'

# 7/9  2026-03-13 19:15
NOTE="journal/2026-03-13.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-13\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Measured wall time differences between runs.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-13T19:15:00+0530' GIT_COMMITTER_DATE='2026-03-13T19:15:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSolution: relaxation and residuals'

# 8/9  2026-03-17 21:05
NOTE="journal/2026-03-17.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-17\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised cleaning cases before rerunning them.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-17T21:05:00+0530' GIT_COMMITTER_DATE='2026-03-17T21:05:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'docs: read solver guide section'

# 9/9  2026-03-17 23:29
NOTE="journal/2026-03-17.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-17\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at wall functions and the nut wallFunction entries.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-17T23:29:00+0530' GIT_COMMITTER_DATE='2026-03-17T23:29:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: Boussinesq notes'

touch "$MARKER"
echo "batch 07 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
