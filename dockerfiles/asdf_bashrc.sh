#!/bin/bash
# asdf setup
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# dotnet tools
export PATH="$PATH:~/.dotnet/tools"

# dotnet root dir
export DOTNET_ROOT=~/.asdf/installs/dotnet-core/3.1.417