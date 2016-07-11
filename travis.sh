#!/bin/sh
# Script to run when testing core-plans on Travis CI
set -x

# debug info
echo "TRAVIS_COMMIT=$TRAVIS_COMMIT"
echo "TRAVIS_COMMIT_RANGE=$TRAVIS_COMMIT_RANGE"

PARENT_COMMIT=$(git log --pretty=%P -n 1 "$TRAVIS_COMMIT")
echo "PARENT_COMMIT=$PARENT_COMMIT"
## end debug

pre-commit install

# Retrieve the canonical range.
# The TRAVIS_COMMIT env var is always a merge commit, so we want to test from
# the original commit all the way up until HEAD.
ORIGIN=$(echo "$TRAVIS_COMMIT_RANGE" | cut -f1 -d'.')

pre-commit run --origin "$ORIGIN" --source HEAD
