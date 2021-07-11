@test "zstd exe runs" {
  run hab pkg exec $TEST_PKG_IDENT zstd
  [ $status -eq 0 ]
}

expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
@test "zstd exe output mentions expected version $expected_version" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" zstd -- -h | head -1 | grep -o -E '[0-9]+\.[0-9]+\.[0-9]+')"
  [ "$actual_version" = "$expected_version" ]
}

@test "zstdcat exe runs" {
  run hab pkg exec $TEST_PKG_IDENT zstdcat -- --help
  [ $status -eq 0 ]
}

function basic_grep {
  echo 'cat' | hab pkg exec $TEST_PKG_IDENT  zstdgrep -- 'cat'
}
@test "zstdgrep exe runs" {
  run basic_grep
  [ $status -eq 0 ]
  [ "$output" = 'cat' ]
}

@test "zstdless exe runs" {
  run hab pkg exec $TEST_PKG_IDENT zstdless -- --help
  [ $status -eq 0 ]
}

@test "zstdmt exe runs" {
  run hab pkg exec $TEST_PKG_IDENT zstdmt -- --help
  [ $status -eq 0 ]
}

@test "unzstd exe runs" {
  run hab pkg exec $TEST_PKG_IDENT unzstd -- --help
  [ $status -eq 0 ]
}
