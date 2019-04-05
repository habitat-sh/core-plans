#!/bin/bash

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAN_ROOT="$(cd "$(dirname "${__dir}")" && pwd)"

source "${PLAN_ROOT}/test/lib/habitat.bash"

SKIPBUILD=${SKIPBUILD:-0}
if [ "${SKIPBUILD}" -eq 0 ]; then
  habitat::build_git
fi

habitat::load_git
habitat::test_git

