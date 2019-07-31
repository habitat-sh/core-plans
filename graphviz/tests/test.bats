@test "minimal dot to svg works" {
  run hab pkg exec $TEST_PKG_IDENT dot -Tsvg -o ${BATS_TEST_DIRNAME}/output.svg < "${BATS_TEST_DIRNAME}/input.dot"
  echo $output >&3
  [ $status -eq 0 ]
  [ -f "${BATS_TEST_DIRNAME}/output.svg" ]
  rm -f "${BATS_TEST_DIRNAME}/output.svg"
}
