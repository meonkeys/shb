#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Run all the messy typesetting code in src/ and capture outputs. This is
# better than mucking up src/Makefile with paths, and it keeps src/ clean by
# just moving the PDF, EPUB, etc. outputs into build/ afterwards.
#
# FIXME - tech debt - duplicate logic - slows down build
#
# This is lazy and slow and 100% good enough for now.

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
