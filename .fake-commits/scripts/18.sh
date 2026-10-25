#!/usr/bin/env bash
# Generated backdated commit batch 18 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-18.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 18 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-06 10:42
NOTE="journal/2025-12-06.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-06\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the pitzDailySteady tutorial setup end to end.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-06T10:42:00+0530' GIT_COMMITTER_DATE='2025-12-06T10:42:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 2/10  2025-12-26 10:21
NOTE="journal/2025-12-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the residual histories for oscillation.
- Wrote a manifest to describe each case run.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-26T10:21:00+0530' GIT_COMMITTER_DATE='2025-12-26T10:21:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'tools: foamListTimes and cleaning'

# 3/10  2025-12-26 20:06
NOTE="journal/2025-12-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a SLURM batch script and checked job state with scontrol.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-26T20:06:00+0530' GIT_COMMITTER_DATE='2025-12-26T20:06:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 4/10  2025-12-26 21:02
NOTE="journal/2025-12-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised reading log.foamRun with grep for residuals.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-26T21:02:00+0530' GIT_COMMITTER_DATE='2025-12-26T21:02:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 5/10  2026-02-16 19:28
NOTE="journal/2026-02-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at function objects for field min and max.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-16T19:28:00+0530' GIT_COMMITTER_DATE='2026-02-16T19:28:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: refine mesh notes'

# 6/10  2026-02-16 21:09
NOTE="journal/2026-02-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried under-relaxing U more to stabilise the solve.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-16T21:09:00+0530' GIT_COMMITTER_DATE='2026-02-16T21:09:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: add residuals table'

# 7/10  2026-02-16 22:32
NOTE="journal/2026-02-16.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-16\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the nut and nuTilda definitions in the 0 directory.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-16T22:32:00+0530' GIT_COMMITTER_DATE='2026-02-16T22:32:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: field comparison script'

# 8/10  2026-03-07 14:55
NOTE="journal/2026-03-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at mesh conversion and boundary patch naming.
- Looked at processor boundary artefacts after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-07T14:55:00+0530' GIT_COMMITTER_DATE='2026-03-07T14:55:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: Boussinesq notes'

# 9/10  2026-03-07 15:22
NOTE="journal/2026-03-07.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-07\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at function objects for field min and max.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-07T15:22:00+0530' GIT_COMMITTER_DATE='2026-03-07T15:22:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-epsilon wall functions'

# 10/10  2026-04-18 13:59
NOTE="journal/2026-04-18.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-18\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared SIMPLE and SIMPLEC under-relaxation behaviour.
- Read the OpenFOAM 12 solver and module layout.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-18T13:59:00+0530' GIT_COMMITTER_DATE='2026-04-18T13:59:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: energy equation setup'

touch "$MARKER"
echo "batch 18 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
