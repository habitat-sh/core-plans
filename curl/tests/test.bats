expected_version=$(cut -d/ -f3 <<< $TEST_PKG_IDENT)

@test "Version matches" {
  result="$(hab pkg exec $TEST_PKG_IDENT curl --version | head -1 | awk '{print $2}')"
  [ "$result" = "${expected_version}" ]
}
