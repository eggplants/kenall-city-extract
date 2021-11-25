#!/usr/bin/env bash

latexmk -c --quiet
ls *.dvi *.synctex.gz *.bbl 2> /dev/null | xargs rm
