#!/usr/bin/env bash

# This script will emit valid YAML that is consumed by expeditor to generate a buildkite pipeline.
# There should be no output from this script that is not YAML as that will cause the pipeline generation
# to fail. The exception to this (for now) is when we need to emit a known failure case.
#
# Each pipeline will be unique, in that it generates a known set of steps for each Plan that was changed
# as part of the PR. The steps are defined in verify_linux_pipeline.yml (for Linux) and
# verify_windows_pipeline.yml (for Windows).
git config --global --add safe.directory /workdir
set -euo pipefail

default_base_branch='main'
base_branch="${BUILDKITE_PULL_REQUEST_BASE_BRANCH:-$default_base_branch}"

# Ensure base branch is always up to date when generating our pipeline
git fetch origin "$base_branch" --quiet


# Determine the files changed between this PR and the base branch (usually master).
# Group them by plan and use that as the unit of work in
# downstream steps.
plans_changed() {
  git diff --name-only "${TEST_BRANCH:-HEAD}" "$(git merge-base "${TEST_BRANCH:-HEAD}" "origin/${base_branch}")" \
  | cut -f1 -d/ \
  | sort \
  | uniq
}

# This uses token replacement from a pipeline template to generate steps for each changed Plan
# that is part of a PR. This allows us to define in a generic form what linting, tests and other
# actions we should take on a Plan, without having to define the same set of actions individually
# for each core-plan.
emit_pipeline() {
  local pipeline_template
  local plan

  pipeline_template="$1"
  plan="$2"

  sed "s|@@plan@@|$plan|" "$pipeline_template"
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

cat .expeditor/templates/verify.pipeline.yml

# shellcheck disable=SC2068
for plan in ${plans[@]}; do
  if [[ -f $plan/plan.sh ]] || [[ -f $plan/plan.ps1 ]]; then
    emit_pipeline .expeditor/templates/verify_shared_pipeline.yml "$plan"
  fi

  if [[ -f $plan/plan.sh ]]; then
    emit_pipeline .expeditor/templates/verify_linux_pipeline.yml "$plan"
    emit_pipeline .expeditor/templates/verify_armlinux_pipeline.yml "$plan"
  fi

  if [[ -f $plan/plan.ps1 ]]; then
    emit_pipeline .expeditor/templates/verify_windows_pipeline.yml "$plan"
  fi

  # TODO(SM): Handle queuing based on .bldr.toml
  # example: postgres change _should_ also verify builds of postgresql9x
  # since they share definitions
done
