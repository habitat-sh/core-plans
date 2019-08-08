expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "jenkins binary version matches ${expected_version}" {
  actual_version="$(java -jar $(hab pkg path ${HAB_ORIGIN}/jenkins)/jenkins.war --version)"
  diff <( echo "$actual_version") <( echo "${expected_version}")
}

@test "Service is running" {
  [ "$(hab svc status | grep "jenkins\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 80 (HTTP)" {
  # ensure that both ipv6 "::ffff:172.17.0.2:80" and ipv4 "172.17.0.2:80" will match
  [ "$(netstat -peanutl | grep java | awk '{print $4}' | awk -F':' '{print $NF}' | grep 80 )" ]
}
