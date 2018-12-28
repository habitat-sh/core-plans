source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(nvcc --version | tail -1 | awk '{print $6}' | tr -d 'V')"
  [ "$result" = "${pkg_version}" ]
}
