TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" hugo version | awk '{print $5}')"
  [ "$result" = "v${TEST_PKG_VERSION}/extended" ]
}

@test "Help command" {
  run hab pkg exec "${TEST_PKG_IDENT}" hugo help
  [ "$status" -eq 0 ]
}

@test "Generate new site" {
  run hab pkg exec "${TEST_PKG_IDENT}" hugo new site testsite
  [ "$status" -eq 0 ]
  [ -d testsite ]
  [ -f testsite/config.toml ]
  rm -rf testsite
}
