#!/bin/sh
TESTDIR="$(dirname "${0}")"
PLANDIR="$(dirname "${TESTDIR}")"
SKIPBUILD=${SKIPBUILD:-0}

hab pkg install core/busybox-static
hab pkg binlink core/busybox-static netstat

hab pkg install --binlink core/bats
source "${PLANDIR}/plan.sh"

if [ "${SKIPBUILD}" -eq 0 ]; then
  set -e
  pushd "${PLANDIR}" > /dev/null
  build
  source results/last_build.env
  hab svc load -f core/nginx
  echo '[http.listen]
port = 81' | hab config apply nginx.default "$(date +%s)"
  # Unload the service if its already loaded.
  hab svc unload "${HAB_ORIGIN}/${pkg_name}"
  hab pkg install --binlink --force "results/${pkg_artifact}"
  hab svc load "${pkg_ident}" --bind=backend:nginx.default
  popd > /dev/null
  set +e
fi

echo "Waiting 5 seconds hoping haproxy will start..."
sleep 5

bats "${TESTDIR}/test.bats"
