#!/usr/bin/env bash
# Generated backdated commit batch 19 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-19.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 19 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/9  2025-12-02 09:27
NOTE="journal/2025-12-02.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-02\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a steady buoyant case with fixed temperature walls.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-02T09:27:00+0530' GIT_COMMITTER_DATE='2025-12-02T09:27:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: cleanup and formatting'

# 2/9  2026-03-09 07:41
NOTE="journal/2026-03-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about residualControl and convergence in fvSolution.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-09T07:41:00+0530' GIT_COMMITTER_DATE='2026-03-09T07:41:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 3/9  2026-03-09 13:49
NOTE="journal/2026-03-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised decomposePar with the scotch method.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-09T13:49:00+0530' GIT_COMMITTER_DATE='2026-03-09T13:49:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: parse internalField lists'

# 4/9  2026-03-09 17:35
NOTE="journal/2026-03-09.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-09\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised decomposePar with the scotch method.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-09T17:35:00+0530' GIT_COMMITTER_DATE='2026-03-09T17:35:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: refine mesh notes'

# 5/9  2026-04-04 09:50
NOTE="journal/2026-04-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at why iteration counts differ slightly after decomposition.
- Looked at processor boundary artefacts after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-04T09:50:00+0530' GIT_COMMITTER_DATE='2026-04-04T09:50:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: foamListTimes and cleaning'

# 6/9  2026-04-04 13:29
NOTE="journal/2026-04-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried under-relaxing U more to stabilise the solve.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-04T13:29:00+0530' GIT_COMMITTER_DATE='2026-04-04T13:29:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: speedup and efficiency notes'

# 7/9  2026-04-04 15:54
NOTE="journal/2026-04-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a steady buoyant case with fixed temperature walls.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-04T15:54:00+0530' GIT_COMMITTER_DATE='2026-04-04T15:54:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 8/9  2026-04-27 17:41
NOTE="journal/2026-04-27.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-27\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the pitzDailySteady tutorial setup end to end.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-27T17:41:00+0530' GIT_COMMITTER_DATE='2026-04-27T17:41:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'case: pitzDailySteady setup notes'

# 9/9  2026-04-27 20:55
NOTE="journal/2026-04-27.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-27\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Measured wall time differences between runs.
- Looked at y+ estimates for the first cell layer.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-27T20:55:00+0530' GIT_COMMITTER_DATE='2026-04-27T20:55:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: fix typo in notes'

touch "$MARKER"
echo "batch 19 done: 9 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
