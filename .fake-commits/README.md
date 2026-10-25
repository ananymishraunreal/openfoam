# Backdated commit batches

20 scripts, 190 commits across 99 days.

- Window 1: 2025-12-01 .. 2026-01-31
- Window 2: 2026-02-15 .. 2026-04-30
- Gap 2026-02-01 .. 2026-02-14 intentionally empty
- 1-3 commits per active day, random days, random times (07:30-23:30 IST)
- Each commit appends a few OpenFOAM study bullets to `journal/YYYY-MM-DD.md`
- Author date and committer date are both backdated

## Run

One batch at a time:

```bash
bash .fake-commits/scripts/01.sh
```

Then commit 02 tomorrow, and so on. Batches are shuffled, so order does not
matter; run them in any order you like.

Push only when you want to:

```bash
bash .fake-commits/scripts/01.sh --push
```

## Safety

- Refuses to run if tracked files are modified or staged.
- Refuses to run twice: markers live in `.fake-commits/.state/`, which is
  outside git history.
- GPG signing disabled per commit (`-c commit.gpgsign=false --no-verify`), so
  no prompt and no hook failures.
- Nothing pushes unless `--push` is passed. Pushing 20 batches within a few
  minutes looks worse than not pushing at all; spread runs out or push once at
  the end.
- `.fake-commits/` itself stays untracked, so it never lands in history.

## Undo

All batches are plain commits on `main` on top of `1a8ddc3`. Before pushing:

```bash
git reset --hard 1a8ddc3   # discards every fake commit, keeps working dir clean
```

After pushing, undoing means a force-push, which rewrites published history.

## Regenerate

The schedule is deterministic (seed 20251201):

```bash
python3 .fake-commits/generate.py
```

Rerunning it rebuilds the same scripts byte for byte, overwriting `scripts/`.
The repo root is taken from the script's own location, so this directory works
wherever the repo lives.
