@test "zookeeper service is running" {
  [ "$(hab svc status | grep "zookeeper\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "zookeeper matches version ${expected_version}" {
  actual_version_array=($(cat "${SUP_LOG}" | grep --text -m 1 -oP "(?<=zookeeper.version=)([^-]*)" | tail -n 1))
  diff <( echo "${actual_version_array[0]}") <(echo "${expected_version}")
}
