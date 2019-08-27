TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Service is running" {
  echo -e "$(hab svc status)"
  [ "$(hab svc status | grep "kafka\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 9092" {
  result="$(netstat -peanut | grep java | grep LISTEN | awk '{print $4}' | awk -F':' '{print $2}' | grep 9092 || echo 'Not found')"
  [ "${result}" -eq 9092 ]
}
