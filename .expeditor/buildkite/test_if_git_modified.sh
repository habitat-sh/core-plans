#!/bin/bash

set -eou pipefail

: "${CODE?"CODE must be set in environment"}"

if [[ $(did-modify --globs="$CODE" --git_ref=origin/master) == "true" ]]; then
  # To standardise the InSpec command, there should always be an attributes.yml
  touch "$CODE/attributes.yml"
  ruby .expeditor/buildkite/test_core_plan_linux.rb -p "$CODE"
else
  echo "Not running tests for $CODE because it has not been modified relative to origin/master"
fi
