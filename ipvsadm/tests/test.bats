TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} ipvsadm -- --version | awk '{print $2}')"
  [ "$result" = "v${TEST_PKG_VERSION}" ]
}

@test "Help Command Check" {
  run hab pkg exec ${TEST_PKG_IDENT} ipvsadm -- --help
  [ $status -eq 0 ]

  run hab pkg exec ${TEST_PKG_IDENT} ipvsadm-save -- -h
  [ "${lines[0]}" = "ipvsadm-save: Script to save the IPVS table to stdout." ]
  [ $status -eq 1 ]
}

@test "Display the ipvs table" {
  run hab pkg exec ${TEST_PKG_IDENT} ipvsadm --list
  [ $status -eq 0 ]
}
