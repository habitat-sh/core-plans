#!/bin/sh

TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install --binlink core/bats

source "${PLANDIR}/plan.sh"

if [ "${SKIPBUILD}" -eq 0 ]; then
  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  source results/last_build.env
  hab pkg install --binlink --force "results/${pkg_artifact}"
  ln -sf "$(hab pkg path core/iana-etc)/etc/protocols" /etc/protocols
  popd > /dev/null
  set +e
fi

if [[ ! -f /etc/protocols ]]; then
	hab pkg install core/iana-etc
	ln -s "$(hab pkg path core/iana-etc)/etc/protocols" /etc/protocols
fi

bats "${TESTDIR}/test.bats"
