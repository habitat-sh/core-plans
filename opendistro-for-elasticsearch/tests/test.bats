TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Service is running" {
  [ "$(hab svc status | grep "opendistro-for-elasticsearch\.default" | awk '{print $4}' | grep up)" ]
}

@test "Open port 9200" {
  result="$(netstat -peanut | grep java | grep 9200)"
  [ $? -eq 0 ]
}

@test "Open port 9300" {
  result="$(netstat -peanut | grep java | grep 9300)"
  [ $? -eq 0 ]
}

@test "Correct plugin version" {
  result="$(curl -sk https://admin:admin@0.0.0.0:9200/_cluster/stats | jq -r '.nodes.plugins[0].version')"
  [ "${result}" = "${TEST_PKG_VERSION}" ]
}

@test "Using OSS distribution" {
  result="$(curl -sk https://admin:admin@0.0.0.0:9200 | jq -r '.version.build_flavor')"
  [ "${result}" = "oss" ]
}

@test "Service Healthcheck" {
  local addr="$(netstat -lnp | grep 9200 | head -1 | awk '{print $4}')"
  result="$(curl -sk https://admin:admin@0.0.0.0:9200/_cluster/health | jq -r '.status')"
  [ "${result}" = "green" ]
}
