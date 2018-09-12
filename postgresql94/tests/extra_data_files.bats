NONHAB_FILE="/hab/svc/postgresql94/data/lost+found"

function setup() {
  touch "${NONHAB_FILE}"
  chown root:root "${NONHAB_FILE}"
  chmod 600 "${NONHAB_FILE}"
}

function teardown() {
    rm -f ${NONHAB_FILE}
}

@test "Non-hab owned files in /data are allowed" {
  ORIGIN=$(hab svc status |grep postgresql94| cut -f1 -d'/')
  hab svc stop "${ORIGIN}/postgresql94"

  hab svc start "${ORIGIN}/postgresql94"

  # Wait for service to start
  sleep 1

  # We still have a non-hab owned file in data/
  [ -f "${NONHAB_FILE}" ]
  [ "root" == $(stat -c %U "${NONHAB_FILE}") ]
  [ "root" == $(stat -c %G "${NONHAB_FILE}") ]
  [ "-rw-------" == $(stat -c %A "${NONHAB_FILE}") ]

  [ "$(hab svc status | grep "postgresql94.default" | awk '{print $4}' | grep up)" ]
}
