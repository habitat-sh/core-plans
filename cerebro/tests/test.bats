source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(curl http://localhost:9000 | grep appVersion | awk '{print $6}' | tr -d "'\"\>" | tr -d 'v')"
  [ "$result" = "${pkg_version}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "cerebro\.default" | awk '{print $4}' | grep up)" ]
}
