#!/bin/bash
# This script gets the repo via params:
#   ./publish --repo https://private.repo/url

REPO=$@

publish() {
  (
    cd $1
    local name=$(cat package.json | grep name | head -n 1 | cut -d'"' -f 4)
    local targetVersion=$(cat package.json | grep version | head -n 1 | cut -d'"' -f 4)
    local currentVersion=$(npm info $REPO | grep version: | cut -d"'" -f 2)
    if [ -z "$currentVersion" ]; then currentVersion="0.0.0"; fi
    echo "$name@$currentVersion -> $targetVersion"
    if [ "$currentVersion" != "$targetVersion" ]; then npm publish $REPO; fi
  )
}

for i in ./packages/awesome*; do publish $i; done