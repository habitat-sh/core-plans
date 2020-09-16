TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  run hab pkg exec ${TEST_PKG_IDENT} grep --version
  [ "${lines[0]}" == "grep (GNU grep) ${TEST_PKG_VERSION}" ]
}

@test "Simple pattern" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} grep "^pkg_name" < grep/plan.sh)"
  [ "$result" == "pkg_name=grep" ]
}
