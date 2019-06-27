@test "Version matches plan" {
  TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" openssl version | awk '{print $1,$2}')"
  diff <( echo "$actual_version" ) <( echo "OpenSSL ${TEST_PKG_VERSION}-fips" )
}

@test "Encodes successfully" {
  actual="$(echo "a_byte_character" | hab pkg exec "${TEST_PKG_IDENT}" openssl enc -base64)"
  diff <( echo "$actual" ) <( echo "YV9ieXRlX2NoYXJhY3Rlcgo=" )
}
