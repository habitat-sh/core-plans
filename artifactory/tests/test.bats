TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
load helpers

@test "Port Listen TCP/8081" {
  test_listen tcp 8081
  [ "$?" -eq 0 ]
}

@test "API is functional" {
  result="$(curl -s http://0.0.0.0:8081/artifactory/api/repositories | jq -r '.errors[0].message')"
  [ "${result}" = "Authentication is required" ]
}
