#!/bin/bash

# Typeset book _Steadfast Self-Hosting_
# Copyright (C) 2024-2025  Adam Monsen
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
# Performs typesetting in a container.                       #
# Requires Docker.                                           #
##############################################################

set -o errexit
set -o nounset
set -o pipefail

SECONDS=0
echo "🏗️	start at $(date)"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORK_DIR=/usr/src/app/book
GID="$(id -g)"
BUILD_DATE_TIME="$(date)"
BUILD_LOCALE_LANG="${LANG:-en_US.UTF-8}"
BUILD_GIT_COMMIT="$(git rev-parse --short HEAD || echo FIXME)"
BUILD_GIT_BRANCH="$(git branch --show-current || echo FIXME)"
# Seems to pull the most recent tag if the current commit has more than one.
# We shouldn't count on this behavior, though.
BUILD_GIT_TAG="$(git describe --tags --abbrev=0 || echo FIXME)"
# standard or premium - only applies to print PDF
BUILD_PRINT_QUALITY="${SHB_FORCE_PRINT_QUALITY:-standard}"

if [[ "$OSTYPE" =~ linux-gnu ]]; then
    BUILD_OS_RELEASE="$(lsb_release --short --description || echo FIXME)"
else
    # OSTYPE is intentionally coarse.
    # There are surely better ways to get detailed build OS info.
    BUILD_OS_RELEASE="${OSTYPE:-unknown}"
fi

echo '🚢	build image'
cd "$SCRIPT_DIR"
# discard container checksum
docker build \
    --tag shb-asciidoctor \
    --build-arg WORK_DIR="$WORK_DIR" \
    --file .Dockerfile \
    --quiet \
    . \
    > /dev/null

echo '🚢	start container'
docker run \
    --rm \
    --interactive \
    --tty \
    --volume "$SCRIPT_DIR:$WORK_DIR" \
    --env BUILD_DATE_TIME="$BUILD_DATE_TIME" \
    --env BUILD_LOCALE_LANG="$BUILD_LOCALE_LANG" \
    --env BUILD_GIT_COMMIT="$BUILD_GIT_COMMIT" \
    --env BUILD_GIT_BRANCH="$BUILD_GIT_BRANCH" \
    --env BUILD_GIT_TAG="$BUILD_GIT_TAG" \
    --env BUILD_OS_RELEASE="$BUILD_OS_RELEASE" \
    --env BUILD_PRINT_QUALITY="$BUILD_PRINT_QUALITY" \
    --env BUILD_OUTPUT_UID="$UID" \
    --env BUILD_OUTPUT_GID="$GID" \
    shb-asciidoctor \
    "$@"

echo "🏗️	done (${SECONDS}s elapsed)"
