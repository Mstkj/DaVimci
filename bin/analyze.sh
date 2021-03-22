#!/bin/bash


# TODO: 'sort' alphanumeric/alphabetic order if no chronological or hierarchical order <21-03-21, melthsked> #
# TODO: use 'time' <21-03-21, melthsked> #

function main() {
  exec ./test.awk
}

if ! main; then exit 1
else exit 0; fi
