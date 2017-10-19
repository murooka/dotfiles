#!/bin/bash

set -ue

if [ "$(uname)" == "Darwin" ]; then
  . ./init_darwin.sh
elif [ "$(uname)" == "Linux" ]; then 
  . ./init_linux.sh
else
  echo "unknown OS"
fi
