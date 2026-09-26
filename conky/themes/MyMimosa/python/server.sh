#!/bin/bash
echo "dirname/readlink: $( dirname -- "$( readlink -f -- "$0"; )"; )"
LOCATION=$( dirname -- "$( readlink -f -- "$0"; )"; )
uv run python -m http.server 9845 --directory $LOCATION
