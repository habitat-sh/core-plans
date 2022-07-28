@test "Version matches" {
	expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
	result="$(tar  --version | head -1 | awk '{print $4}')"
	[ "$result" = "${expected_version}" ]
}
