#!/bin/sh

set -euo pipefail

THIS_TEST_DIR="$(dirname "${0}")"

source "${THIS_TEST_DIR}/../../ruby/tests/test.sh" "$1"
