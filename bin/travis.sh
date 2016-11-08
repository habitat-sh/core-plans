#!/bin/bash
# Script to run when testing core-plans on Travis CI

# Don't run if we're on the auto branch. Using the right range for pre-commit
# has been problematic, so we're just going to skip it until somebody figures
# it out.
# [[ "$TRAVIS_BRANCH" = "auto" ]] && exit 0;

pre-commit install

# The TRAVIS_COMMIT env var is always a merge commit, so we want to test from
# the original commit all the way up until HEAD.
echo $TRAVIS_COMMIT_RANGE
ORIGIN=$(echo "$TRAVIS_COMMIT_RANGE" | cut -f1 -d'.')
echo "COMMIT RANGE STARTS AT $ORIGIN"


pre-commit run --files go/plan.sh #--origin "$ORIGIN" --source HEAD
