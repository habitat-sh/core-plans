TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
load helpers

@test "Port Listen TCP/8081" {
  test_listen tcp 8081
  [ "$?" -eq 0 ]
}

@test "API is functional" {
  local addr="$(netstat -lnp | grep 8081 | head -1 | awk '{print $4}')"
  result="$(curl -s http://${addr}/artifactory/api/repositories | jq -r '.[].key')"
  [ "${result}" = "example-repo-local" ]
}
