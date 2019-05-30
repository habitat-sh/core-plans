TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" named -v | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Dig" {
  run hab pkg exec "${TEST_PKG_IDENT}" dig a localhost
  [ $status -eq 0 ]
}

@test "Host" {
  run hab pkg exec "${TEST_PKG_IDENT}" host 127.0.0.1
  [ $status -eq 0 ]

  run hab pkg exec "${TEST_PKG_IDENT}" host 127.0.0.1.x
  [ $status -eq 1 ]
}

@test "ARPAname" {
  run hab pkg exec "${TEST_PKG_IDENT}" arpaname 127.0.0.1
  [ $status -eq 0 ]
}

@test "DNSSec Keygen" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" dnssec-keygen -a RSASHA512 test)"
  status=$?
  [ $status -eq 0 ]

  keyname="$(echo "${result}" | tail -1)"
  [ -f "${keyname}.key" ]
  [ -f "${keyname}.private" ]
}
