#!/usr/bin/env bash

set -euf -o pipefail

if [[ "$#" -lt 1 ]]; then
  echo "Usage ..."
  exit 1
fi

