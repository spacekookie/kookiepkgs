#!/bin/sh

set -e

SOURCE=$1
TARGET=$(dirname $SOURCE)
ACCOUNT=$(basename $SOURCE .yml)
if [ -z $SOURCE ]; then
  echo "Usage: invoice <file>"
  exit 2
fi

echo $TARGET

# The reason behind this awk madness is that we want to be able to write
# a date as yyyy-mm-dd in the invoice descriptor, but LaTeX needs the
# date as three elements to fill in a {d}{m}{y} pattern. Thus we replace
# a simple "date" line with three seperate fields that we can then read
# from LaTeX
cat $SOURCE | xargs -d '\n' -L 1 \
  | awk -F '-' '{ if(match($0, /date/)) { gsub(/date: /,"", $1); \
    print "date_year: " $1 "\n" "date_month: " $2 "\n" "date_day: " $3 } \
    else { print $0} }' \
  | pandoc - -o $TARGET/$ACCOUNT.pdf --template=$TEMPLATE_FILE --pdf-engine=xelatex
