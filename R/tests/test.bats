expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
@test "R runs" {
  run hab pkg exec $TEST_PKG_IDENT R -- --version
  [ $status -eq 0 ]
}

@test "R is expected version $expected_version" {
  version="$(hab pkg exec $TEST_PKG_IDENT R -- --version | head -1 | cut -d\  -f3)"
  [ "$version" = "$expected_version" ]
}

@test "Rscript runs" {
  run hab pkg exec $TEST_PKG_IDENT Rscript -- --version
  [ $status -eq 0 ]
}

@test "Rscript is expected version $expected_version" {
  # Rscript reports version to stderr so 2>&1 is used.
  actual_version="$(hab pkg exec $TEST_PKG_IDENT Rscript -- --version 2>&1 | gawk '{ if (match($0,/[0-9]+\.[0-9]+\.[0-9]+/,m)) print m[0] }')"
  [ "$actual_version" = $expected_version ]
}
