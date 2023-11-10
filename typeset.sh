#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

TOPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

remove() {
    if [[ -x /usr/bin/trash ]]
    then
        trash "$1" || true
    else
        rm -rf "$1"
    fi
}

echo "[$(date)] - START $0"

cd "$TOPDIR"

remove "$TOPDIR/build/"

cd "$TOPDIR/src"

make

mkdir -p "$TOPDIR/build"
mv SteadfastSelfHosting-PRINT.pdf SteadfastSelfHosting-SCREEN.pdf SteadfastSelfHosting.html SteadfastSelfHosting.epub "$TOPDIR/build"
make clean

echo "[$(date)] - END $0"
