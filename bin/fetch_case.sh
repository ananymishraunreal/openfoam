#!/usr/bin/env bash
# fetch_case.sh — pinned sparse fetch
# usage: fetch_case.sh <repo_url> <pinned_sha> <case_out_dir> [sparse paths...]

set -euo pipefail

repo=$1; pin=$2; dest=$3; shift 3
work=$(mktemp -d /tmp/opencode/sl-fetch.XXXXXX)

cleanup() {
    rm -rf "$work"
}
trap cleanup EXIT

clone=$work/clone

git init -q "$clone"
git -C "$clone" remote add origin "$repo"
if ! git -C "$clone" cat-file -e "$pin^{commit}" 2>/dev/null; then
    git -C "$clone" fetch -q --depth 1 origin "$pin" 2>/dev/null || git -C "$clone" fetch -q origin "$pin"
fi
got=$(git -C "$clone" rev-parse FETCH_HEAD)
if [ "$got" != "$pin" ]; then
    echo "PIN MISMATCH: wanted $pin got $got" >&2
    exit 1
fi

if [ "$#" -gt 0 ]; then
    git -C "$clone" sparse-checkout init --cone >/dev/null
    git -C "$clone" sparse-checkout set "$@" >/dev/null
fi
git -C "$clone" checkout -q "$pin"

# single raw file -> copy straight over dest path (idempotent overwrite)
if [ "$#" -eq 1 ] && [ -f "$clone/$1" ] && [ ! -d "$dest" ]; then
    cp -T "$clone/$1" "$dest"
    echo "OK fetched $repo @ ${pin:0:12}" >&2
    exit 0
fi

if [ -n "$dest" ]; then
    mkdir -p "$dest"
    if [ "$#" -gt 0 ]; then
        # copy each sparse path on its own: dir -> dest flat, file -> dest
        for p in "$@"; do
            if [ -d "$clone/$p" ]; then
                cp -rT "$clone/$p" "$dest"
            elif [ -f "$clone/$p" ]; then
                cp -T "$clone/$p" "$dest"
            else
                echo "WARNING: sparse path missing: $p" >&2
            fi
        done
    else
        cp -rT "$clone/." "$dest/"
    fi
    printf '%s %s %s\n' "$repo" "$pin" "$*" > "$dest/.SOURCE"
fi

echo "OK fetched $repo @ ${pin:0:12}" >&2
