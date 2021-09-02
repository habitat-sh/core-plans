source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(rg --version | head -1 | awk '{print $2}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run rg --help
  [ $status -eq 0 ]
}

@test "Usage test no params" {
  run rg
  [ $status -eq 2 ]
}

@test "Usage test with params" {
  result=$(rg "ripgrep" /src | rg "raw speed")
  [ $? -eq 0 ]
  lines=$(echo "${result}" | wc -l)
  [ $lines -eq 3 ]
}
