#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

service=$1
shift

set -o xtrace
sudo docker compose --file "/root/ops/$service/compose.yml" "$@"
