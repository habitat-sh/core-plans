source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Run A Scan With Gradle" {
  run gradle --scan
  [ $status -eq 0 ]
}

@test "Version matches" {
  result="$(gradle --version | head -n 3 | tail -n 1 | awk '{print $2}' | tr -d ' ')"
  [ "$result" = "${pkg_version}" ]
}
