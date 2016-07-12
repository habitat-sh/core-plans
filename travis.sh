#!/bin/bash
# Script to run when testing core-plans on Travis CI
set -x

# debug info
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH"
echo "TRAVIS_COMMIT=$TRAVIS_COMMIT"
echo "TRAVIS_COMMIT_RANGE=$TRAVIS_COMMIT_RANGE"
echo "HEAD=$(git rev-parse HEAD)"

PARENT_COMMIT=$(git log --pretty=%P -n 1 "$TRAVIS_COMMIT")
echo "PARENT_COMMIT=$PARENT_COMMIT"
## end debug

pre-commit install

# Retrieve the canonical range.
# If we're on the auto branch, the origin should be auto
if [[ "$TRAVIS_BRANCH" = "auto" ]]; then
  ORIGIN=auto
# The TRAVIS_COMMIT env var is always a merge commit, so we want to test from
# the original commit all the way up until HEAD.
else
  ORIGIN=$(echo "$TRAVIS_COMMIT_RANGE" | cut -f1 -d'.')
fi

pre-commit run --origin "$ORIGIN" --source HEAD
