source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(java -jar $(hab pkg path rakops/jenkins)/jenkins.war --version)"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run java -jar $(hab pkg path rakops/jenkins)/jenkins.war --help
  [ $status -eq 0 ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "jenkins\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 80 (HTTP)" {
  [ "$(netstat -peanut | grep java | awk '{print $4}' | awk -F':' '{print $2}' | grep 80)" ]
}
