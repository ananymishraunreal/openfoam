#!/bin/bash
set -e
[ -d 0 ] || cp -r initial 0
blockMesh
setSolidFraction -subDivisions 6
transformPoints -rotate '((0 1 0) (0 0 1))'
