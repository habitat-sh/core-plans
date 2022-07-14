@test "Version matches" {
	expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"
	result="$(vim  --version | sed '3!d' | awk '{print $6}')"
	[ "$result" = "${expected_version}" ]
}
