expected_version=$(cut -d/ -f3 <<< $TEST_PKG_IDENT)

@test "Version matches" {
  result="$(hab pkg exec $TEST_PKG_IDENT curl -- --version | head -1 | awk '{print $2}')"
	echo "result : $result"
	echo "exp: $expected_version"
  [ "$result" = "${expected_version}" ]
}

@test "Curl against https sites" {
  run hab pkg exec $TEST_PKG_IDENT curl -s -o /dev/null -w "%{http_code}" "https://www.example.org/"
  [ "$output" -eq 200 ]
}
