#!/bin/sh

set -e

SOURCE=$1
TARGET=$(dirname $SOURCE)
ACCOUNT=$(basename $SOURCE .yml)
if [ -z $SOURCE ]; then
  echo "Usage: invoice <file>"
  exit 2
fi

pandoc $SOURCE -o $DIRNAME/$ACCOUNT.pdf \
  --template=$TEMPLATE_FILE --pdf-engine=xelatex
