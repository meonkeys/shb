#!/bin/bash

# Invoke rake to build _Steadfast Self-Hosting_
# Copyright (C) 2024  Adam Monsen
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

##############################################################
# Build the book, generating various typeset output formats. #
##############################################################

set -o errexit
set -o nounset
set -o pipefail

#bundle exec asciidoctor-pdf --version
#exit 1

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
