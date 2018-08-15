#!/bin/sh

hab pkg install --binlink core/bats

source ./plan.sh

set -e
build
source results/last_build.env
hab pkg install --binlink --force "results/${pkg_artifact}"
set +e

bats test.bats
