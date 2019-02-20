source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Command is on path" {
  [ "$(command -v metricbeat)" ]
}

@test "Version matches" {
  result="$(metricbeat version | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run metricbeat --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "metricbeat\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep -v "test" | grep metricbeat | wc -l)"
  [ "${result}" -eq 1 ]
}
