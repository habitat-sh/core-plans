#!/bin/bash
# Script to run when testing core-plans on Travis CI

# Don't run if we're on the auto branch. Using the right range for pre-commit
# has been problematic, so we're just going to skip it until somebody figures
# it out.
[[ "$TRAVIS_BRANCH" = "auto" ]] && exit 0;

pre-commit install

# The TRAVIS_COMMIT env var is always a merge commit, so we want to test from
# the original commit all the way up until HEAD.
ORIGIN=$(echo "$TRAVIS_COMMIT_RANGE" | cut -f1 -d'.')

pre-commit run --origin "$ORIGIN" --source HEAD
