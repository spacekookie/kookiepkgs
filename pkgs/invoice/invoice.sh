#!/bin/sh

set -e

TARGET=$1
ACCOUNT=$(basename $TARGET .yml)
if [ -z $TARGET ]; then
  echo "Usage: invoicer <file>"
  exit 2
fi

pandoc $TARGET -o $ACCOUNT.pdf --template=../share/template.tex --pdf-engine=xelatex
