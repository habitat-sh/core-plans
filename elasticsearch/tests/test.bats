source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(elasticsearch --version | awk '{print $2}' | tr -d ',')"
  [ "$result" = "${pkg_version}" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "elasticsearch\.default" | awk '{print $4}' | grep up)" ]
}

@test "Open port 9200" {
  result="$(netstat -peanut | grep java | grep 9200)"
  [ $? -eq 0 ]
}

@test "Open port 9300" {
  result="$(netstat -peanut | grep java | grep 9300)"
  [ $? -eq 0 ]
}

@test "Service Healthcheck" {
  local addr="$(netstat -lnp | grep 9200 | head -1 | awk '{print $4}')"
  result="$(curl -s http://${addr}/_cluster/health | jq -r '.status')"
  [ "${result}" = "green" ]
}
