TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

# TODO: how to check binary is linked with musl libc?

@test "is binary statically linked" {
	result="$(hab pkg exec core/file file /hab/pkgs/${TEST_PKG_IDENT}/bin/curl)"
	echo "res : $result"
	[[ "$result" == *"statically linked"* ]]
}

@test "Version matches" {
  result="$(hab pkg exec ${TEST_PKG_IDENT} curl -- --version | head -1 | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Curl against https sites" {
  run hab pkg exec ${TEST_PKG_IDENT} curl -- -s -o /dev/null -w "%{http_code}" "https://www.example.org/"
  [ "$output" -eq 200 ]
}

@test "JSON output" {
  run hab pkg exec ${TEST_PKG_IDENT} curl -- -s -o /dev/null -w "%{json}" "https://www.example.org/"
  jq -ne --argjson output "$output" '$output.http_code == 200'
}
