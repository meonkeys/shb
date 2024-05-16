#!/bin/python3

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

import os
import subprocess
import sys

validBuildTargets = ['html', 'printPdf', 'screenPdf', 'epub', 'checkhtml', 'checkepub']

commonArgs = [
    '--attribute', 'build_date_time=' + os.environ['BUILD_DATE_TIME'],
    '--attribute', 'build_locale_lang=' + os.environ['BUILD_LOCALE_LANG'],
    '--attribute', 'build_git_commit=' + os.environ['BUILD_GIT_COMMIT'],
    '--attribute', 'build_git_branch=' + os.environ['BUILD_GIT_BRANCH'],
    '--attribute', 'build_git_tag=' + os.environ['BUILD_GIT_TAG'],
    '--attribute', 'build_os_release=' + os.environ['BUILD_OS_RELEASE'],
    '--warnings',
    '--trace',
    '--require', '/usr/local/bundle/gems/asciidoctor-lists-1.0.9/lib/asciidoctor-lists.rb'
]

title = 'steadfast'
bookSrc = title + '.asciidoc'

def log(msg):
    print(msg)

args = sys.argv[1:]

if len(args) == 0 or len(args) == 1 and args[0] == 'all':
    args = validBuildTargets

for arg in args:
    if arg not in validBuildTargets:
        log('⚠️\tinvalid argument(s)')
        log('')
        log(f'Usage: {sys.argv[0]} [all|TARGET...]')
        log('')
        log('TARGET is one or more of ' + ' '.join(validBuildTargets))
        sys.exit(1)

def typeset(command, outputType, outputName):
    log(f'🖨️\ttypeset {outputType}')
    subprocess.run(command, check=True)
    log(f'💾\twrote {outputName}')

htmlOutput = f'{title}.html'
epubOutput = f'{title}.epub'
printPdfOutput = f'{title}.print.pdf'
screenPdfOutput = f'{title}.screen.pdf'

extendConverter = ['--require', './.extensions.rb']

for arg in args:
    match(arg):
        case 'html':
            command = ['asciidoctor'] + commonArgs + ['--attribute', 'data-uri', bookSrc]
            typeset(command, 'HTML', htmlOutput)
        case 'printPdf':
            command = ['asciidoctor-pdf'] + commonArgs + extendConverter + ['--attribute', 'shb-printPDF', '--out-file', printPdfOutput, bookSrc]
            typeset(command, 'print-ready PDF', printPdfOutput)
        case 'screenPdf':
            command = ['asciidoctor-pdf'] + commonArgs + extendConverter + ['--attribute', 'shb-screenPDF', '--out-file', screenPdfOutput, bookSrc]
            typeset(command, 'screen-optimized PDF', screenPdfOutput)
        case 'epub':
            command = ['asciidoctor-epub3'] + commonArgs + [bookSrc]
            typeset(command, 'EPUB', epubOutput)
        case 'checkhtml':
            if 'html' not in args:
                log('⚠️\tHTML was not built -- checking anyway')
            subprocess.run(['htmlproofer', htmlOutput], check=False)
        case 'checkepub':
            if 'epub' not in args:
                log('⚠️\tEPUB was not built -- checking anyway')
            subprocess.run(['epubcheck', epubOutput], check=False)
