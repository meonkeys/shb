# Build the book

## Usage

```bash
./build.sh
```

The build script is meant to be run as a user other than root able to run `docker` commands.
It runs in Bash on Linux and macOS, maybe Windows too.
Requires Docker and a few common cli tools.

## Avoid Docker

Building without Docker is unsupported, but this might make it work for you:

1. install prerequisites mentioned in `Dockerfile`
1. set environment variables mentioned in `build.sh`
1. run `python3 .internal-build.py`
