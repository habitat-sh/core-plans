source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(nload --help | head -2 | tail -1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Can nload" {
  run nload -h
  [ $status -eq 0 ]
}
