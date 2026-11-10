#!/bin/sh
# Builds postiz-patched:<version> = official image + *.patch in this folder.
# Usage: ./build.sh v2.25.3
set -e
VERSION="${1:?usage: ./build.sh <postiz version, e.g. v2.25.3>}"
cd "$(dirname "$0")"
docker build --build-arg POSTIZ_VERSION="$VERSION" -t "postiz-patched:$VERSION" .
echo "Built postiz-patched:$VERSION - set it as the postiz image in the Coolify compose (with pull_policy: never)."
