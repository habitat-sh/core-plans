source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(hab pkg exec "${PKGIDENT}" hugo version | awk '{print $5}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Help command" {
  run hab pkg exec "${PKGIDENT}" hugo help
  [ "$status" -eq 0 ]
}

@test "Generate new site" {
  run hab pkg exec "${PKGIDENT}" hugo new site testsite
  [ "$status" -eq 0 ]
  [ -d testsite ]
  [ -f testsite/config.toml ]
  rm -rf testsite
}
