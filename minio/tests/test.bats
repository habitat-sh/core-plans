source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v minio)" ]
}

@test "Version matches, via help output" {
  run minio --help
  [ "$status" -eq 0 ]
  version="$(echo "${lines[-1]}" | sed 's/:/-/g')"
  [ "$version" = "  ${pkg_version}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "minio\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep "minio server" | wc -l)"
  [ "${result}" -eq 1 ]
}

@test "Listening on port 9000" {
  [ "$(netstat -peanut | grep minio | awk '{print $4}' | awk -F':' '{print $2}' | grep 9000)" ]
}
