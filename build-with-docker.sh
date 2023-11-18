#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

GID="$(id -g)"
GROUP="$(id -gn)"
BUILD_DATE_TIME="$(date)"
BUILD_GIT_COMMIT="$(git log -n 1 --pretty=format:%H || echo FIXME)"
BUILD_OS_RELEASE="$(lsb_release --short --description || echo FIXME)"

set -o xtrace

sudo docker build \
    --tag shb-asciidoctor \
    --build-arg USER="$USER" \
    --build-arg UID="$UID" \
    --build-arg GROUP="$GROUP" \
    --build-arg GID="$GID" \
    .

mkdir -p ~/Downloads/shb-asciidoctor-outputs

sudo docker run \
    --rm \
    --interactive \
    --tty \
    --user "$USER:$GROUP" \
    --volume "$HOME/Downloads/shb-asciidoctor-outputs:/outputs" \
    --env BUILD_DATE_TIME="$BUILD_DATE_TIME" \
    --env BUILD_GIT_COMMIT="$BUILD_GIT_COMMIT" \
    --env BUILD_OS_RELEASE="$BUILD_OS_RELEASE" \
    shb-asciidoctor