#!/bin/bash

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAN_ROOT="$(cd "$(dirname "${__dir}")" && pwd)"

source "${PLAN_ROOT}/test/lib/habitat.bash"

SKIPBUILD=${SKIPBUILD:-0}
if [ "${SKIPBUILD}" -eq 0 ]; then
  habitat::build_haproxy
fi

habitat::load_haproxy
habitat::test_haproxy

