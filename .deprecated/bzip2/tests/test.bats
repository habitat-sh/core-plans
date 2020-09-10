expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "bzip2 version matches ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" bzip2 --help 2>&1 | grep -oP '(?<=Version )([^,]*)')"
  diff <( echo "${actual_version}" ) <( echo "${expected_version}" )
}
