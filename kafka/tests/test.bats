TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Service is running" {
  echo -e "$(hab svc status)"
  [ "$(hab svc status | grep "kafka\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 9092" {
  result="$(netstat -at | grep LISTEN | grep -o 9092 || echo '-1')"
  [ "${result}" -eq 9092 ]
}
