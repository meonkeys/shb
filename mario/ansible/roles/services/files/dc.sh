#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

service=$1
shift

set -o xtrace
docker-compose --file "/root/ops/$service/docker-compose.yml" "$@"
