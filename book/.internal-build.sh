#!/bin/bash

# Build _Steadfast Self-Hosting_ formatted book outputs
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

title=steadfast
book_src=$title.asciidoc

common_args=(
    --attribute build_date_time="$BUILD_DATE_TIME"
    --attribute build_git_commit="$BUILD_GIT_COMMIT"
    --attribute build_os_release="$BUILD_OS_RELEASE"
    --warnings
    --trace
)

function typeset_html() {
    echo '🖨️	typeset HTML'
    asciidoctor "${common_args[@]}" --attribute data-uri $book_src
    echo "💾	wrote $title.html"
}

function typeset_print_pdf() {
    echo '🖨️	typeset print-ready PDF'
    output=$title.print.pdf
    asciidoctor-pdf "${common_args[@]}" --attribute shb-printPDF --require ./extensions.rb --out-file $output $book_src
    echo "💾	wrote $output"
}

if [[ "$BUILD_TYPE" == "small" ]]; then
    typeset_html
    typeset_print_pdf
else
    typeset_html
    typeset_print_pdf

    echo '🖨️	typeset EPUB'
    asciidoctor-epub3 "${common_args[@]}" $book_src
    echo "💾	wrote $title.epub"

    echo '🖨️	typeset FB2'
    asciidoctor-fb2 "${common_args[@]}" $book_src
    echo "💾	wrote $title.fb2.zip"

    echo '🖨️	typeset Mobi'
    asciidoctor-epub3 "${common_args[@]}" --attribute ebook-format=kf8 $book_src
    echo "💾	wrote $title-kf8.epub and $title.mobi"

    echo '🖨️	typeset screen-optimized PDF'
    output=$title.screen.pdf
    asciidoctor-pdf "${common_args[@]}" --attribute shb-screenPDF --out-file $output $book_src
    echo "💾	wrote $output"

    echo '📋	check links in HTML output'
    htmlproofer $title.html

    echo '📋	validate EPUB output'
    # does something very similar to passing `--attribute ebook-validate` to `asciidoctor-epub3`
    epubcheck $title.epub
fi
