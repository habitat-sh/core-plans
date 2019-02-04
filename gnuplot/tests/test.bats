source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(gnuplot --version | awk '{print $2,".",$4}' | tr -d " ")"
  [ "$result" = "${pkg_version}" ]
}
