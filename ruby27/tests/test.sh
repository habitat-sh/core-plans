#!/bin/bash

set -euo pipefail

THIS_TEST_DIR="$(dirname "${0}")"

source "${THIS_TEST_DIR}/test.sh" "$1"
