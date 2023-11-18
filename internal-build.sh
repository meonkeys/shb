#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

bundle exec rake

cp --target-directory=/outputs -- *.epub *.fb2.zip *.html *.mobi *.pdf
