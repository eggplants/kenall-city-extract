#!/usr/bin/env bash

if [[ "$1" =~ ^.*tex$ ]]; then
  latexmk  -pv -shell-escape
  latexmk -c --quiet
  ls *.dvi *.synctex.gz *.bbl 2> /dev/null | xargs rm
else
  echo "Usage: $0 <tex>">&2
  exit 1
fi
