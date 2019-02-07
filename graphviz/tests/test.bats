source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "dot is on the path" {
  [ "$(command -v dot)" ]
}

@test "minimal dot to svg works" {
  run dot -Tsvg -o ${BATS_TEST_DIRNAME}/output.svg < "${BATS_TEST_DIRNAME}/input.dot"
  [ $status -eq 0 ]
  [ -f "${BATS_TEST_DIRNAME}/output.svg" ]
  rm -rf "${BATS_TEST_DIRNAME}/otuput.svg"
}
