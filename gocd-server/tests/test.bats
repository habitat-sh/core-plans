@test "gocd-server service is running" {
  [ "$(hab svc status | grep "gocd-server\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "gocd-server matches version ${expected_version}" {
  actual_version_array=($(cat /hab/sup/default/sup.log | grep --text -m 1 -oP "(?<=GoCD Version: )([^-]*)"))
  diff <( echo "${actual_version_array[0]}") <(echo "${expected_version}")
}
