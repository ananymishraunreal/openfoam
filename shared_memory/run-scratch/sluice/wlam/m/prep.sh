#!/bin/bash
set -e
blockMesh
topoSet
createPatch -overwrite
rm -rf 0 && mkdir 0 && cp 0.orig/* 0/
for f in 0/*.orig; do mv "$f" "${f%.orig}"; done
setFields
