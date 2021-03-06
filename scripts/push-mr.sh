#!/bin/bash

# push with -u origin and open create MR link

git push --no-verify -u origin $(git rev-parse --abbrev-ref HEAD) 2>&1 \
  | grep 'https://gitlab.com' | awk '{print $2}' | xargs openfile
