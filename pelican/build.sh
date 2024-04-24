#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

SECONDS=0
echo "🏗️	start at $(date)"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORK_DIR=/usr/src/app
IMAGE_NAME=shb-website-generator
GID="$(id -g)"
GROUP="$(id -gn)"

lockfile=/var/lock/publish-shb-website.lock
(
    if ! flock --nonblock 9
    then
        echo "🗝️	failed to acquire lock - check if $0 is already running"
        exit 1
    fi

    images="$(docker images -q $IMAGE_NAME | wc -l)"

    if [[ $images -eq 0 ]]; then
        echo '🚢	build image'
        docker build \
            --tag $IMAGE_NAME \
            --build-arg WORK_DIR="$WORK_DIR" \
            --build-arg USER="$USER" \
            --build-arg UID="$UID" \
            --build-arg GROUP="$GROUP" \
            --build-arg GID="$GID" \
            --quiet \
            . \
            > /dev/null
    fi

    echo '🚢	start container'
    docker run \
        --rm \
        --interactive \
        --tty \
        --user "$USER:$GROUP" \
        --publish 8000:8000 \
        --volume "$SCRIPT_DIR:$WORK_DIR" \
        $IMAGE_NAME \
        "$@"

) 9> "$lockfile"

echo "🏗️	done (${SECONDS}s elapsed)"
