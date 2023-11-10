# filter.py - Part of build system for the book
#   Steadfast Self-Hosting: Rapid-Rise Personal Cloud
# Copyright (C) 2023  Adam Monsen
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

# This is a simple templating engine.


import os, sys, re, subprocess, yaml


# slurp in raw content
content = sys.stdin.read()


# highlight static placeholders
# These are added manually to call out unfinished parts of the book.
content = re.sub(r'(\W)(TODO|FIXME)(\W)', r'\1<span class="todo">\2</span>\3', content)


# declare variables for placeholder substitutions
# gather value if it can be done in one line
buildDateTime = os.popen('date').read().strip()
buildGitCommit = 'TODO'
buildLang = 'TODO'
buildOsRelease = os.popen('lsb_release --short --description').read().strip()


# gather remaining values
with open('metadata.yaml', 'r') as rawMetadata:
    docs = yaml.safe_load_all(rawMetadata)
    metadata = next(docs, 'FIXME')
    buildLang = metadata['lang']
gitLogResult = subprocess.run(['git', 'log', '-n', '1', '--pretty=format:%H'], capture_output=True, encoding='utf-8')

if gitLogResult.stdout:
    buildGitCommit = gitLogResult.stdout

if gitLogResult.stderr:
    msg = f'{sys.argv[0]} warning: unable to retrieve git commit. stderr from git command was [{gitLogResult.stderr.strip()}]'
    print(msg, file=sys.stderr)
    buildGitCommit = 'FIXME'


# substitute placeholders with gathered values
content = re.sub(r'%%BUILD_DATE_TIME%%', buildDateTime, content)
content = re.sub(r'%%BUILD_GIT_COMMIT%%', buildGitCommit, content)
content = re.sub(r'%%BUILD_OS_RELEASE%%', buildOsRelease, content)
content = re.sub(r'%%BUILD_LANG%%', buildLang, content)


# dump filtered content
# placeholder left as TODO  → gathering this value is not yet implemented
# placeholder left as FIXME → variable substitution failed at runtime
print(content)
