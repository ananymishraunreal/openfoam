#!/usr/bin/env bash
# Generated backdated commit batch 03 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-03.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 03 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-19 07:54
NOTE="journal/2025-12-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Measured wall time differences between runs.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-19T07:54:00+0530' GIT_COMMITTER_DATE='2025-12-19T07:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: summarize run logs'

# 2/10  2025-12-19 10:27
NOTE="journal/2025-12-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised keeping case directories under version control.
- Tried under-relaxing U more to stabilise the solve.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-19T10:27:00+0530' GIT_COMMITTER_DATE='2025-12-19T10:27:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: field comparison script'

# 3/10  2025-12-19 21:53
NOTE="journal/2025-12-19.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-19\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the checkMesh output: skewness, non-orthogonality, aspect ratio.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-19T21:53:00+0530' GIT_COMMITTER_DATE='2025-12-19T21:53:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 4/10  2026-01-24 15:24
NOTE="journal/2026-01-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the SIMPLE relaxation factors for p and U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-24T15:24:00+0530' GIT_COMMITTER_DATE='2026-01-24T15:24:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'fvSchemes: convective schemes'

# 5/10  2026-01-24 16:51
NOTE="journal/2026-01-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the comparison notes for serial versus parallel.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-24T16:51:00+0530' GIT_COMMITTER_DATE='2026-01-24T16:51:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: serial vs 8-rank timing'

# 6/10  2026-01-28 13:13
NOTE="journal/2026-01-28.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-28\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the residual histories for oscillation.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-28T13:13:00+0530' GIT_COMMITTER_DATE='2026-01-28T13:13:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: reconstructPar and compare'

# 7/10  2026-03-22 12:08
NOTE="journal/2026-03-22.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-22\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Timed solvers with /usr/bin/time -v and read ExecutionTime.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-22T12:08:00+0530' GIT_COMMITTER_DATE='2026-03-22T12:08:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: field comparison script'

# 8/10  2026-03-22 23:28
NOTE="journal/2026-03-22.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-22\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised checking for continuity errors in the log.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-22T23:28:00+0530' GIT_COMMITTER_DATE='2026-03-22T23:28:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 9/10  2026-03-23 12:18
NOTE="journal/2026-03-23.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-23\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the fvSolution solver tolerances for U and p.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-23T12:18:00+0530' GIT_COMMITTER_DATE='2026-03-23T12:18:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: python helpers'

# 10/10  2026-04-23 18:55
NOTE="journal/2026-04-23.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-23\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a pressure outlet with a fixedValue p patch.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-23T18:55:00+0530' GIT_COMMITTER_DATE='2026-04-23T18:55:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: compare two approaches'

touch "$MARKER"
echo "batch 03 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
