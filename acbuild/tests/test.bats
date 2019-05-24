TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "version command gives expected version" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" acbuild version | grep 'acbuild version' | awk '{ print $3 }')"
  [ "$result" = $TEST_PKG_VERSION  ]
}

@test "Start and end a build" {
  run hab pkg exec "${TEST_PKG_IDENT}" acbuild begin
  [ $status -eq 0 ]
  run hab pkg exec "${TEST_PKG_IDENT}" acbuild end
  [ $status -eq 0 ]
}
