source "${BATS_TEST_DIRNAME}/../plan.sh"

NONHAB_FILE="/hab/svc/${pkg_name}/data/lost+found"

function setup() {
  touch "${NONHAB_FILE}"
  chown root:root "${NONHAB_FILE}"
  chmod 600 "${NONHAB_FILE}"
}

function teardown() {
    rm -f ${NONHAB_FILE}
}

@test "Non-hab owned files in /data are allowed" {
  ORIGIN=$(hab svc status |grep ${pkg_name}| cut -f1 -d'/')
  hab svc stop "${ORIGIN}/${pkg_name}"

  hab svc start "${ORIGIN}/${pkg_name}"

  # Wait for service to start
  sleep 1

  # We still have a non-hab owned file in data/
  [ -f "${NONHAB_FILE}" ]
  [ "root" == $(stat -c %U "${NONHAB_FILE}") ]
  [ "root" == $(stat -c %G "${NONHAB_FILE}") ]
  [ "-rw-------" == $(stat -c %A "${NONHAB_FILE}") ]

  [ "$(hab svc status | grep "${pkg_name}.default" | awk '{print $4}' | grep up)" ]
}
