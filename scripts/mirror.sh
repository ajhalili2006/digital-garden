#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0

set -x

export GIT_TRACE=1 GIT_TRANSFER_TRACE=1 GIT_CURL_VERBOSE=1

REPOS="lab vern hub keybase"
branch="$(git rev-parse --abbrev-ref HEAD)"

for remote in $REPOS; do
  # WORKAROUND: git config workaround to make lfs mirroring work outside Keybase.
  if [[ $remote == "keybase" ]]; then
    git config lfs.standalonetransferagent keybase-lfs
    git config --replace-all lfs.lfs.customtransfer.keybase-lfs.path "git-remote-keybase"
    git config --replace-all lfs.customtransfer.keybase-lfs.args "lfs origin keybase://private/ajhalili2006/digital-garden"
  fi

  git lfs push $remote $branch --all
  git push $remote $branch

  # workaround: needed to avoid erroring out by git when still working on markdown files.
  if [[ $remote == "keybase" ]]; then
    git config --unset lfs.standalonetransferagent
  fi
done

unset GIT_TRACE GIT_CURL_VERBOSE GIT_TRANSFER_TRACE
