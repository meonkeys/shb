# strip-non-ascii.py - Part of build system for the book
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

import fileinput, re, sys

# Strip all but 7-bit ASCII (possibly preceded by a space). This is intended to
# catch emoji, which (currently) break PDF generation. The regex removes
# newlines, but these are added back when we print the modified line.

strip_re = r'[^\x20-\x7e]'
compiled_strip_re = re.compile(strip_re)

lineno = 1
for line in fileinput.input():
    matches = re.findall(compiled_strip_re, line)
    for m in matches:
        if m == '\n':
            continue
        charnum = ord(m)
        print(f'will strip {m} (ord={charnum}) from line {lineno}', file=sys.stderr)
    line = re.sub(compiled_strip_re, '', line)
    print(line)
    lineno += 1

# Old regex:
#     r'\s?[^\x20-\x7e]'.
# That one also caught a space character followed by newline/EOL. I try to
# avoid those anyway.
