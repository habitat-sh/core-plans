#!/bin/bash
#/ Builds and verifies the specified plan and any reverse dependencies
#/
#/ Usage:
#/
#/ refresh-verify-change.sh NAME
#/
#/ ex: refresh-verify-change.sh glibc

set -euo pipefail

export HAB_NONINTERACTIVE=true
export HAB_NOCOLORING=true

usage() {
  grep '^#/' < "${0}" | cut -c4-
  exit 1
}

need_cmd() {
  cmd="$1"

  if ! command -v "$cmd" >/dev/null; then
    echo "Could not find $cmd; Please install it first"
  fi
}

[[ -z "${1:-}" ]] && usage

changed_plan="$1"
[[ -d "$changed_plan" ]] || usage

need_cmd "curl"
need_cmd "jq"
need_cmd "tee"

rdeps_url="https://bldr.habitat.sh/v1/rdeps/core/$changed_plan/group"
query='.rdeps | .[] | .idents | map(select(startswith("core"))) |select(length > 0) | .[] | ltrimstr("core/")'
build_id="$(date -u +%Y%m%d%H%M%S)"
build_log_dir="results/$changed_plan-$build_id"

echo "Setting build_id: ${build_id}"
mkdir -p "$build_log_dir"

echo "Getting reverse dependency list"
echo "$changed_plan" > "$build_log_dir"/build_order
curl -s "$rdeps_url" | jq -r "$query" >> "$build_log_dir"/build_order

echo "Building $changed_plan and reverse_dependencies"
while read -r plan; do
  if [[ "$plan" == hab-* || "$plan" == builder-* ]];  then
    echo "Skipping $plan."
    continue
  fi
  if [[ -n "${BASE_ONLY:-}" ]] && ! grep -qx "core-plans/$plan" base-plans.txt; then
    echo "Not a base plan, skipping: $plan"
  else
    build "$plan" | tee "${build_log_dir}/${plan}.build.log"
    cp results/last_build.env "${build_log_dir}/${plan}_build.env"
  fi
done < "$build_log_dir"/build_order

echo "Running tests for $changed_plan and reverse_dependencies"
while read -r plan; do
  if [[ "$plan" == hab-* ]];  then
    continue
  fi
  if [[ -f "$plan/tests/test.sh" && -f "${build_log_dir}/${plan}_build.env" ]]; then
    (
        source "${build_log_dir}/${plan}_build.env"
        "$plan"/tests/test.sh "$pkg_ident" | tee "${build_log_dir}/${plan}.verify.log"
    )
  fi
done < "$build_log_dir"/build_order
