TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Version matches" {
  result="$(hab pkg exec core/openjdk11 java -jar $(hab pkg path ${TEST_PKG_IDENT})/jenkins.war --version)"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "Help command" {
  run hab pkg exec core/openjdk11 java -jar $(hab pkg path ${TEST_PKG_IDENT})/jenkins.war --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "jenkins\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 80 (HTTP)" {
  [ "$(netstat -peanut | grep java | awk '{print $4}' | awk -F':' '{print $2}' | grep 80)" ]
}
