expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "sbt matches version ${expected_version}" {
  # remove extra ansi whitespace before comparing versions.  See https://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream/380778
  run hab pkg exec "${TEST_PKG_IDENT}" sbt about
  actual_version=$(echo "${output}" | sed 's/\x1b\[[0-9;]*m//g' | grep -oP "(?<=This is sbt )(.*)" )
  diff <( echo "XX${actual_version}XX" ) <( echo "XX${expected_version}XX" )
}
