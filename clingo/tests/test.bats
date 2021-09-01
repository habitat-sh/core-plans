@test "Version matches plan" {
  TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" gringo -- --version | grep -E "^gringo version")"
  diff <(echo "$actual_version") <(echo "gringo version ${TEST_PKG_VERSION}")
}

# Refer to https://github.com/potassco/clingo/tree/master/examples/gringo/sort
@test "gringo should work as expected for python" {
  actual=$(hab pkg exec "${TEST_PKG_IDENT}" gringo -- --text ${TESTDIR}/fixtures/examples/gringo/sort/sort-py.lp ${TESTDIR}/fixtures/examples/gringo/sort/encoding.lp)
  expected=$(cat ${TESTDIR}/fixtures/examples/gringo/sort/RESULT_FOR_PYTHON.txt)
  diff <(echo "${actual}") <(echo "${expected}")
}

# Refer to https://github.com/potassco/clingo/tree/master/examples/gringo/sort
@test "gringo should work as expected for lua" {
  actual=$(hab pkg exec "${TEST_PKG_IDENT}" gringo -- --text ${TESTDIR}/fixtures/examples/gringo/sort/sort-lua.lp ${TESTDIR}/fixtures/examples/gringo/sort/encoding.lp)
  expected=$(cat ${TESTDIR}/fixtures/examples/gringo/sort/RESULT_FOR_LUA.txt)
  diff <(echo "${actual}") <(echo "${expected}")
}
