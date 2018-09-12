source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v postgres)" ]
}

@test "Version matches, via --version" {
  run postgres --version
  [ "$status" -eq 0 ]
  version="$(echo "${lines}" | cut -f3 -d' ')"
  [ "${version}" == "${pkg_version}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "postgresql96\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep "postgres -c config" | wc -l)"
  [ "${result}" -eq 1 ]
}

@test "Listening on port 5432" {
  [ "$(netstat -peanut | grep postgres | awk '{print $4}' | awk -F':' '{print $2}' | grep 5432)" ]
}
