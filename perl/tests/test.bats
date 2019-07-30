@test "Runs hello-world" {
  run hab pkg exec $TEST_PKG_IDENT perl $BATS_TEST_DIRNAME/fixtures/hello.pl
  [ "$output" == "Hello, World!" ]
}
