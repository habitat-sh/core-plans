TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
load helpers

@test "Port Listen TCP/8181" {
  test_listen tcp 8181
  [ "$?" -eq 0 ]
}

@test "/v1/data/system/version endpoint returns version" {
  curl -f http://127.0.0.1:8181/v1/data/system/version |
    jq -e --arg vsn "$TEST_PKG_VERSION" '.result.version == $vsn'
}

@test "/v1/query endpoint returns an answer" {
  curl -f http://127.0.0.1:8181/v1/query -d '{"query": "truth := 2+2 == 5"}' |
    jq -e '.result[] | .truth == false'
}
