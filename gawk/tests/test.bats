source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(awk --version | head -1 | awk '{print $3}' | tr -d ',')"
  [ "$result" = "${pkg_version}" ]
}
