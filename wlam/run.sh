#!/usr/bin/env bash
set -euo pipefail
exec sluice run --manifest /home/anany/shared_anany/wlam/manifest.yaml "$@"
