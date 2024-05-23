# Build the book

## Usage

```bash
./build.sh
```

The `build.sh` Bash script requires Docker and a few common cli tools.
It is meant to be run as a user other than `root` with access to Docker.
It runs on Linux and macOS, maybe Windows too.
A `Makefile` is also provided as a convenience to short-circuit rapid repeated builds since the fastest possible `build.sh` invocation may still take several seconds.

## How to build without Docker

Building without Docker is unsupported, but this might make it work for you:

1. install prerequisites mentioned in `.Dockerfile`
1. set environment variables mentioned in `build.sh`
1. run `python3 .internal-build.py`

## macOS notes

See:

1. `darwin` in `build.sh`
1. `.Dockerfile.insecure`
