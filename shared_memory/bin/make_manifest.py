#!/usr/bin/env python3
"""make_manifest.py — hash a directory tree and emit a MANIFEST.json

usage: make_manifest.py <project_dir> <meta.json>
where meta.json holds: {"project":..., "sources":[...], "license":...}
"""
import hashlib
import json
import os
import sys
import time

SKIP_NAMES = {"MANIFEST.json", "meta.json"}


def sha256_of(path):
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(65536), b""):
            h.update(chunk)
    return h.hexdigest()


def main(root, meta_path):
    files = []
    for dirpath, _, names in os.walk(root):
        for nm in sorted(names):
            if nm in SKIP_NAMES or nm == ".SOURCE":
                continue
            p = os.path.join(dirpath, nm)
            rel = os.path.relpath(p, root)
            files.append(
                {
                    "path": rel,
                    "bytes": os.path.getsize(p),
                    "sha256": sha256_of(p),
                }
            )
    files.sort(key=lambda e: e["path"])
    with open(meta_path) as mh:
        meta = json.load(mh)
    total = sum(f["bytes"] for f in files)
    out = {
        **meta,
        "fetched_at": time.strftime("%Y-%m-%d"),
        "total_bytes": total,
        "n_files": len(files),
        "files": files,
    }
    with open(os.path.join(root, "MANIFEST.json"), "w") as wh:
        json.dump(out, wh, indent=1)
        wh.write("\n")
    print(f"{root}: {len(files)} files, {total} bytes")


main(sys.argv[1], sys.argv[2])
