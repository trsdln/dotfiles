#!/bin/bash

# push with -u origin and open create MR link

open_create_mr_url() {
  echo "$1"
  openfile $1
}

git push --no-verify -u origin $(git rev-parse --abbrev-ref HEAD) 2>&1 \
  | grep 'https://gitlab.com' | awk '{print $2}' | xargs open_create_mr_url
