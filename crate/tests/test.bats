source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(crate -v | awk '{print $2}' | tr -d ',')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help flag works" {
    run crate -help
    [ $status -eq 0 ]
}
