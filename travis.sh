#!/bin/sh
# Script to run when testing core-plans on Travis CI
set -x

pre-commit install

# Retrieve the canonical range.
# The TRAVIS_COMMIT env var is always a merge commit, so we want to test from
# the original commit all the way up until HEAD.
ORIGIN=$(echo "$TRAVIS_COMMIT_RANGE" | cut -f1 -d'.')

pre-commit run --origin "$ORIGIN" --source HEAD
