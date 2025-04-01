#!/bin/bash

# provision.sh - mario system provisioner
# Copyright (C) 2023-2025  Adam Monsen
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

set -o errexit
set -o nounset
set -o pipefail

minimumAnsibleCoreVersion="2.16.1"

# So we can refer back to the folder where this script lives.
DIR="$( builtin cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ensure the Ansible program we need is available.
aprun="$(which ansible-playbook)" || true
if ! [[ -x "$aprun" ]]
then
    echo "ERROR: Ansible not installed or not found in path."
    exit 1
fi

if ! ansible --version | grep -q core
then
    echo "ERROR: Ansible core $minimumAnsibleCoreVersion or later required, but was not found."
    exit 1
fi

# Only perform advanced Ansible version checks on GNU/Linux because it's more likely to have compatible versions of grep, sed, sort, etc.
# I think the only real compatibility issue right here is "sort -V".
# Alternatives to this verlte are available at https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash
# Or maybe a better solution would be to enforce GNU sort/coreutils as a dependency?
# homebrew provides gsort on macOS when one installs coreutils.
if [[ "$OSTYPE" =~ linux-gnu ]]; then
    # Ensure minimum viable Ansible core version.
    # Example related issue: https://github.com/ansible/ansible/issues/81946
    thisAnsibleCoreVersion="$(ansible --version | grep core | sed -e 's/^.\+\([0-9]\+\.[0-9]\+\.[0-9]\+\).\+$/\1/')"
    # verlte is from kanaka's answer to https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash
    function verlte() {
        [[ "$1" = "$(echo -e "$1\n$2" | sort -V | head -n1)" ]]
    }
    if ! [[ "$thisAnsibleCoreVersion" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
    then
        echo "ERROR: Ansible core $minimumAnsibleCoreVersion or later required. Unable to determine version."
        exit 1
    fi
    if ! verlte "$minimumAnsibleCoreVersion" "$thisAnsibleCoreVersion"
    then
        echo "ERROR: Ansible core $minimumAnsibleCoreVersion or later required. Version is too old."
        exit 1
    fi
fi

# Create customizable config file if it doesn't exist.
myConfig="$DIR/config"
if ! [[ -r $myConfig ]]
then
    echo "You don't have a config file. I'll create one for you now."
    echo
    echo "Please edit '$myConfig' and re-run this script."
    cp "$DIR/template/config" "$myConfig"
    chmod 600 "$myConfig"
    exit 1
fi

# Test connection to server Ansible will use.
if ! ssh -o BatchMode=yes mario_server true
then
    echo "Error: unable to SSH to the server in batch mode."
    echo
    echo "Please fix your SSH client config and try again."
    exit 1
fi

# shellcheck disable=SC1090
source "$myConfig"

# Reorient ourselves, just in case we're being run from another folder.
builtin cd "$DIR"

# sudo may be used to gain root privileges without a password after the first run.
if [[ -r "$DIR/.first-run-complete" ]]
then
    $aprun playbook.yml
else
    $aprun playbook.yml --ask-become-pass
    touch "$DIR/.first-run-complete"
fi
