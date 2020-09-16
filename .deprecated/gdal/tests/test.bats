source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(gdalenhance | tail -n 2 | head -1 | awk '{print $2}' | tr -d ',')"
  [ "$result" = "${pkg_version}" ]
}
