#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "$BUILD_TYPE" == "full" ]]; then
    bundle exec rake
    cp --target-directory=/outputs -- *.epub *.fb2.zip *.html *.mobi *.pdf
elif [[ "$BUILD_TYPE" == "small" ]]; then
    bundle exec rake book:build_html
    cp --target-directory=/outputs -- *.html
    bundle exec rake book:build_pdf
    cp --target-directory=/outputs -- *.pdf
else
    echo "⛔ ERROR, unknown build type"
    exit 1
fi
