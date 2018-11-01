source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(img version | head -2 | tail -1 | awk '{print $3}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Image list" {
  run img ls
  [ $status -eq 0 ]
}

@test "Build from scratch" {
  run img build -t habitat/test-img .
}