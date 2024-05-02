#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# Ansible discards stdout. Write to stderr so Ansible outputs something useful when this script exits nonzero (e.g. why PHP linting failed).
docker run --rm --interactive php:8.2-apache-bookworm php -l < "$1" | tr '\n' '|' > /dev/stderr
