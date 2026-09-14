#!/bin/zsh

set -e

container run \
  --rm \
  --publish 4000:4000 \
  --volume "$(pwd):/site" \
  github-pages