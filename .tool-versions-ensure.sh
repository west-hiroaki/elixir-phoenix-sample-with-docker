#!/bin/bash

set -e

if ! which asdf > /dev/null; then
  cat <<-"EOF"
	Error: asdf is not installed.
	  https://github.com/asdf-vm/asdf
	EOF
  exit 1
fi

function is_added_plugin() {
  for plugin in `asdf plugin-list`; do
    if [ "$plugin" = "$1" ]; then
      return 0
    fi
  done
  return 1
}

if ! is_added_plugin erlang; then
  asdf plugin-add erlang
fi
if ! is_added_plugin elixir; then
  asdf plugin-add elixir
fi

asdf install
