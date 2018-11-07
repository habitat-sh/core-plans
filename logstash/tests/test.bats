source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v logstash)" ]
}

@test "Version matches" {
  result="$(logstash --version | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run logstash --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "logstash\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep -v "test" | grep logstash | wc -l)"
  [ "${result}" -eq 1 ]
}