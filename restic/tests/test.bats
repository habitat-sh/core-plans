source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Commands are on path" {
  [ "$(command -v restic)" ]
}

@test "Version matches" {
  result="$(restic version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}
