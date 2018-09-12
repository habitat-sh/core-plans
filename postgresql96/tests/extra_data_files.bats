NONHAB_FILE="/hab/svc/postgresql96/data/lost+found"

function setup() {
  touch "${NONHAB_FILE}"
  chown root:root "${NONHAB_FILE}"
  chmod 600 "${NONHAB_FILE}"
}

function teardown() {
    rm -f ${NONHAB_FILE}
}

@test "Non-hab owned files in /data are allowed" {
  ORIGIN=$(hab svc status |grep postgresql96| cut -f1 -d'/')
  hab svc stop "${ORIGIN}/postgresql96"

  hab svc start "${ORIGIN}/postgresql96"

  # Wait for service to start
  sleep 1

  # We still have a non-hab owned file in data/
  [ -f "${NONHAB_FILE}" ]
  [ "root" == $(stat -c %U "${NONHAB_FILE}") ]
  [ "root" == $(stat -c %G "${NONHAB_FILE}") ]
  [ "-rw-------" == $(stat -c %A "${NONHAB_FILE}") ]

  [ "$(hab svc status | grep "postgresql96.default" | awk '{print $4}' | grep up)" ]
}
