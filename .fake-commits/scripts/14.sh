#!/usr/bin/env bash
# Generated backdated commit batch 14 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-14.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 14 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2026-01-15 11:59
NOTE="journal/2026-01-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared SIMPLE and SIMPLEC under-relaxation behaviour.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-15T11:59:00+0530' GIT_COMMITTER_DATE='2026-01-15T11:59:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 2/10  2026-01-15 14:09
NOTE="journal/2026-01-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reconstructed fields with reconstructPar and compared serial output.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-15T14:09:00+0530' GIT_COMMITTER_DATE='2026-01-15T14:09:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: reorganise case layout'

# 3/10  2026-01-25 15:58
NOTE="journal/2026-01-25.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-01-25\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised cleaning cases before rerunning them.
- Read the checkMesh output: skewness, non-orthogonality, aspect ratio.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-01-25T15:58:00+0530' GIT_COMMITTER_DATE='2026-01-25T15:58:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'mesh: blockMesh and checkMesh'

# 4/10  2026-02-17 08:49
NOTE="journal/2026-02-17.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-17\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised keeping case directories under version control.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-17T08:49:00+0530' GIT_COMMITTER_DATE='2026-02-17T08:49:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: compare two approaches'

# 5/10  2026-02-26 10:44
NOTE="journal/2026-02-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised decomposePar with the scotch method.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-26T10:44:00+0530' GIT_COMMITTER_DATE='2026-02-26T10:44:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'turbulence: k-omega SST comparison'

# 6/10  2026-02-26 11:53
NOTE="journal/2026-02-26.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-02-26\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Practised cleaning cases before rerunning them.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-02-26T11:53:00+0530' GIT_COMMITTER_DATE='2026-02-26T11:53:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 7/10  2026-03-15 07:39
NOTE="journal/2026-03-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Compared SIMPLE and SIMPLEC under-relaxation behaviour.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-15T07:39:00+0530' GIT_COMMITTER_DATE='2026-03-15T07:39:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'perf: serial vs 8-rank timing'

# 8/10  2026-03-15 18:48
NOTE="journal/2026-03-15.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-15\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at wall functions and the nut wallFunction entries.
- Looked at fvSchemes: upwind versus linearUpwind for U.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-15T18:48:00+0530' GIT_COMMITTER_DATE='2026-03-15T18:48:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: energy equation setup'

# 9/10  2026-04-08 13:08
NOTE="journal/2026-04-08.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-08\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a small Python script to parse internalField lists.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-08T13:08:00+0530' GIT_COMMITTER_DATE='2026-04-08T13:08:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'buoyant: energy equation setup'

# 10/10  2026-04-08 17:02
NOTE="journal/2026-04-08.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-08\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read the OpenFOAM 12 solver and module layout.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-08T17:02:00+0530' GIT_COMMITTER_DATE='2026-04-08T17:02:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

touch "$MARKER"
echo "batch 14 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
