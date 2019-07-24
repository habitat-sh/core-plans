@test "jetty service is running" {
  [ "$(hab svc status | grep "jetty\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "jetty matches version ${expected_version}" {
  actual_version="$(curl -sS -I http://127.0.0.1:8080/ | grep -oP "(?<=Server: Jetty\()([^v]*)" | sed 's/\.$//g')"
  diff <(echo "$actual_version") <(echo "${expected_version}")
}
