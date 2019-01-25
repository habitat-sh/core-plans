source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  results="$(gcloud --version | head -n 1 | awk '{print $NF}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Can nload" {
  run gcloud -h
  [ $status -eq 0 ]
}
