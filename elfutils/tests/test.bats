source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result=$(eu-readelf --version | head -1 | awk '{print $3}')
  status=$?
  [ $status -eq 0 ]
  [ "$result" = "${pkg_version}" ]
}

@test "Help from commands" {
    run eu-readelf --help
    [ "$status" -eq 0 ]

    run eu-nm --help
    [ "$status" -eq 0 ]
}
