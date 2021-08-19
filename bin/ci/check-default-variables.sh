#!/usr/bin/env bash
#
# pre-commit hook:
# Check for Habitat default variables in a plan.sh file
#
# Authors:
# - Mike Fiedler <miketheman@gmail.com>

required_variables=(
  pkg_description
  pkg_license
  pkg_maintainer
  pkg_name
  pkg_origin
  pkg_upstream_url
)

plan_path="$1"
source "${plan_path}"/plan.sh

retval=0

echo "--- :open_book: [$plan_path] Checking for default variables"
for var in "${required_variables[@]}"; do
  if [ -z "${!var}" ]; then
    echo "    Unable to find '$var' in $*"
    retval=1
  fi
done


if [[ $retval -ne 0 ]]; then
  echo "--- :octogonal_sign: Missing required variables"
  echo "Ensure that your plan.sh contains all of:"
  IFS=$'\n'; echo "${required_variables[*]}"
else
  echo "--- :closed_book: [$plan_path] Found all default variables"
fi

exit $retval
