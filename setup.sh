#!/usr/bin/env bash

function ensure_command() {
  if ! (command -v parallel 1>/dev/null); then
    uname | grep -q Darwin && brew install parallel
  fi
  parallel 'if ! (command -v {} 1>/dev/null); then (uname | grep -q Darwin && brew install {}) fi' ::: "$@"
}

ensure_command yamllint shellcheck
parallel 'find . -type f -name "*.{//}" | parallel {/}' ::: yml/yamllint sh/shellcheck
