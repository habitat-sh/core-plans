@test "Version matches" {
  local expected_version
  local result
  expected_version=$(echo "${TEST_PKG_IDENT}" | cut -d '/' -f3)
  result=$(hab pkg exec "${TEST_PKG_IDENT}" elasticsearch --version 2> /dev/null | awk '{print $2}' | tr -d ',')
  [ "${result}" = "${expected_version}" ]
}

@test "Service is running" {
  hab svc status | grep "elasticsearch\.default" | awk '{print $4}' | grep up
}

@test "Open port 9200" {
  netstat -peanut | grep java | grep 9200
}

@test "Open port 9300" {
  netstat -peanut | grep java | grep 9300
}

@test "Service Healthcheck" {
  local addr
  local result
  addr="$(netstat -lnp | grep 9200 | head -1 | awk '{print $4}')"
  result="$(curl -s http://"${addr}"/_cluster/health | jq -r '.status')"
  [ "${result}" = "green" ]
}
