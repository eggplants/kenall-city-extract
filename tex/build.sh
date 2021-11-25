#!/usr/bin/env bash

set -euo pipefail

if [[ "$1" =~ ^.*tex$ ]]; then
  latexmk "$1" -pv -shell-escape
  latexmk -c --quiet
  ls *.dvi *.synctex.gz *.bbl 2> /dev/null | xargs rm
  latexindent -y="defaultIndent:'  '" --overwrite "$1"
else
  echo "Usage: $0 <tex>">&2
  exit 1
fi
