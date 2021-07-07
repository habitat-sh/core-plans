expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "logstash binary matches version ${expected_version}" {
  local actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" logstash -- --version | awk '{print $2}')"
  diff <(echo "${actual_version}") <(echo "${expected_version}")
}

@test "service is running" {
  [ "$(hab svc status | grep "logstash\.default" | awk '{print $4}' | grep up)" ]
}

@test "service has single process" {
  result="$(ps aux | grep -v grep | grep -v "test" | grep logstash | wc -l)"
  [ "${result}" -eq 1 ]
}
