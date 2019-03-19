#!/usr/bin/env bash

# This script will emit valid YAML that is consumed by expeditor to generate a buildkite pipeline.
# There should be no output from this script that is not YAML as that will cause the pipeline generation
# to fail. The exception to this (for now) is when we need to emit a known failure case.
#
# Each pipeline will be unique, in that it generates a known set of steps for each Plan that was changed
# as part of the PR. The steps are defined in verify_linux_pipeline.yml (for Linux) and
# verify_windows_pipeline.yml (for Windows).

set -euo pipefail

# Determine the files changed between this PR and master.
# Group them by plan and use that as the unit of work in
# downstream steps.
plans_changed() {
  git diff --name-only "${BUILDKITE_BRANCH}" "$(git merge-base "${BUILDKITE_BRANCH}" master)" \
  | cut -f1 -d/ \
  | sort \
  | uniq
}

# This uses token replacement from a pipeline template to generate steps for each changed Plan
# that is part of a PR. This allows us to define in a generic form what linting, tests and other
# actions we should take on a Plan, without having to define the same set of actions individually
# for each core-plan. The generic shape of Windows plan validation is slightly different (we need
# to execute on Windows hosts using powershell, for example) but the mechanism for generating the
# pipeline is the same.
create_linux_verify_pipeline_for() {
  local plan
  plan=$1

  sed "s|@@plan@@|$plan|" .expeditor/templates/verify_linux_pipeline.yml
}

create_windows_verify_pipeline_for() {
  local plan
  plan=$1

  ######################################################
  # "Windows pipelines are currently not implemented." #
  ######################################################
  # sed -i "|@@plan@@|$plan|" .buildkite/templates/verify_windows_pipeline.yml
}

# If there were more than 10 plans affected by a change we're not going to run any verify builds
# In most cases, there should only be one affected Plan. If there are more than one the PR should be
# broken into multiple PRs. There are a few scenarios though where there will be more
# (ex: major-version-up) that we want to handle. The 10 limit is somewhat arbitrary, 5 is probably
# sufficient. What this will hopefully prevent is a base-plans refresh scenario tying up our CI,
# when the builds and validation should have already happened.
readarray plans <<< "$(plans_changed)"

if [[ "${#plans[@]}" -gt 10 ]]; then
  echo "--- :octogonal_sign: More than 10 plans are affected by this PR. Halting."
  buildkite-agent annotate --level 'error' ":octogonal_sign: More than 10 plans affected by this PR."
  exit 1
fi

cat .expeditor/verify.pipeline.yml

# shellcheck disable=SC2068
for plan in ${plans[@]}; do
  if [[ -f $plan/plan.sh ]]; then
    create_linux_verify_pipeline_for "$plan"
  fi

  if [[ -f $plan/plan.ps1 ]]; then
    create_windows_verify_pipeline_for "$plan"
  fi

  # TODO(SM): Handle queuing based on .bldr.toml
  # ex: postgres change _should_ also verify builds of postgresql9x
  # since they share definitions
done
