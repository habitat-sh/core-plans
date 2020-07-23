TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} docker version | head -5 | grep Version | awk '{print $2}')"
  diff <(echo "$result") <(echo "${TEST_PKG_VERSION}")
}

@test "Expected executables present" {
  local missing=""
  for exe in containerd containerd-shim ctr docker docker-init docker-proxy dockerd runc; do
    if ! [ -x "/hab/pkgs/$TEST_PKG_IDENT/bin/$exe" ]; then
      missing="${missing} $exe"
    fi
  done
  diff <(echo "$missing") <(echo "")
}

@test "Help command" {
  run hab pkg exec ${TEST_PKG_IDENT} docker --help
  [ $status -eq 0 ]
}
