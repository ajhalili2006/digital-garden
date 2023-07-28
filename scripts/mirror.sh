#!/usr/bin/env bash
set -xe

REPOS="lab vern hub keybase"
branch="$(git rev-parse --abbrev-ref HEAD)"

for remote in $REPOS; do
  git push $remote $branch
done
