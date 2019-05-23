TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} terraform version | head -1 | awk '{print $2}')"
  [ "$result" = "v${TEST_PKG_VERSION}" ]
}

@test "Terraform default workspace" {
  run hab pkg exec ${TEST_PKG_IDENT} terraform workspace list
  [ $status -eq 0 ]
  [ "${lines[0]}" = "* default" ]
}
