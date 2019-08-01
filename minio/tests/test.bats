TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches, via help output" {
  result=$(hab pkg exec ${TEST_PKG_IDENT} minio --help | tail -1 | tr -d ' ' | sed 's/:/-/g')
  [ "$?" -eq 0 ]
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "minio\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep "minio server" | wc -l)"
  [ "${result}" -eq 1 ]
}

@test "Listening on port 9000" {
  [ "$(netstat -peanut | grep minio | awk '{print $4}' | awk -F':' '{print $NF}' | grep 9000)" ]
}
