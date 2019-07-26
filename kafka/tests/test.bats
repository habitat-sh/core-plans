@test "kafka service is running" {
  [ "$(hab svc status | grep "kafka\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "kafka matches version ${expected_version}" {
  actual_version_array=($(cat "${SUP_LOG}" | grep --text -m 1 -oP "(?<=INFO Kafka version : )([^ ]*)"))
  diff <( echo "${actual_version_array[0]}") <(echo "${expected_version}")
}
