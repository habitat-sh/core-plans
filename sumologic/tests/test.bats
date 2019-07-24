@test "sumologic service is running" {
  [ "$(hab svc status | grep "sumologic\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "wrapper matches version ${expected_version}" {
  actual_version_array=($(cat /hab/svc/sumologic/var/collector.out.log | grep -oP "(?<=Sumo Logic Collector Version )(.*)"))
  diff <( echo "${actual_version_array[0]}") <(echo "${expected_version}")
}
