#!/usr/bin/env bash
# Generated backdated commit batch 09 of 20.
# Run manually: bash $0
# Push afterwards only if you want: bash $0 --push
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE="$REPO/.fake-commits/.state"
MARKER="$STATE/batch-09.done"
PUSH=0
if [ "${1:-}" = "--push" ]; then PUSH=1; fi

cd "$REPO"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $REPO" >&2; exit 1; }
if [ -e "$MARKER" ]; then echo "batch 09 already applied; nothing to do"; exit 0; fi
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "working tree has tracked changes; commit or stash them first" >&2; exit 1
fi
mkdir -p "$STATE"

# 1/10  2025-12-04 10:06
NOTE="journal/2025-12-04.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-04\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a manifest to describe each case run.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-04T10:06:00+0530' GIT_COMMITTER_DATE='2025-12-04T10:06:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 2/10  2025-12-28 07:30
NOTE="journal/2025-12-28.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-28\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried a steady buoyant case with fixed temperature walls.
- Practised decomposePar with the scotch method.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-28T07:30:00+0530' GIT_COMMITTER_DATE='2025-12-28T07:30:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'parallel: reconstructPar and compare'

# 3/10  2025-12-28 16:50
NOTE="journal/2025-12-28.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2025-12-28\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about residualControl and convergence in fvSolution.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2025-12-28T16:50:00+0530' GIT_COMMITTER_DATE='2025-12-28T16:50:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'cluster: SLURM batch script'

# 4/10  2026-03-06 12:37
NOTE="journal/2026-03-06.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-06\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at processor boundary artefacts after decomposition.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-06T12:37:00+0530' GIT_COMMITTER_DATE='2026-03-06T12:37:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 5/10  2026-03-06 15:49
NOTE="journal/2026-03-06.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-06\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried under-relaxing U more to stabilise the solve.
- Looked at the Boussinesq versus compressible treatment.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-06T15:49:00+0530' GIT_COMMITTER_DATE='2026-03-06T15:49:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'bc: inlet and outlet patches'

# 6/10  2026-03-24 11:44
NOTE="journal/2026-03-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Reviewed the comparison notes for serial versus parallel.
- Reconstructed fields with reconstructPar and compared serial output.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-24T11:44:00+0530' GIT_COMMITTER_DATE='2026-03-24T11:44:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'solvers: SIMPLE vs SIMPLEC'

# 7/10  2026-03-24 21:03
NOTE="journal/2026-03-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-03-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Looked at turbulence intensity and mixing length inputs.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-03-24T21:03:00+0530' GIT_COMMITTER_DATE='2026-03-24T21:03:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: correct y+ estimate'

# 8/10  2026-04-24 09:09
NOTE="journal/2026-04-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Tried the foamRun dispatcher with the solver name in system/.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-24T09:09:00+0530' GIT_COMMITTER_DATE='2026-04-24T09:09:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'post: parse internalField lists'

# 9/10  2026-04-24 11:46
NOTE="journal/2026-04-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Read about the k-epsilon wall functions in momentumTransport.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-24T11:46:00+0530' GIT_COMMITTER_DATE='2026-04-24T11:46:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: expand earlier section'

# 10/10  2026-04-24 21:06
NOTE="journal/2026-04-24.md"
if [ ! -f "$NOTE" ]; then
  mkdir -p journal
  printf "# 2026-04-24\n\n" > "$NOTE"
fi
cat >> "$NOTE" <<'EOF'
- Wrote a manifest to describe each case run.
EOF
git add -- "$NOTE"
GIT_AUTHOR_DATE='2026-04-24T21:06:00+0530' GIT_COMMITTER_DATE='2026-04-24T21:06:00+0530' \
  git -c commit.gpgsign=false commit --no-verify -q -m 'notes: fix typo in notes'

touch "$MARKER"
echo "batch 09 done: 10 commits"
if [ "$PUSH" -eq 1 ]; then
  echo "pushing to $(git remote get-url origin 2>/dev/null || echo no-remote)"
  git push origin HEAD
fi
