source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(telegraf version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "telegraf\.default" | awk '{print $4}' | grep up)" ]
}
