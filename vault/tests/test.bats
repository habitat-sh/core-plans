source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(vault version | awk '{print $2}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Help command" {
  run vault --help
  [ $status -eq 0 ]
  [ "${lines[0]}" = "Usage: vault <command> [args]" ]
}

@test "Service is running" {
  [ "$(hab svc status | grep "vault\.default" | awk '{print $4}' | grep up)" ]
}

@test "A single process" {
  result="$(ps aux | grep -v grep | grep "vault server" | wc -l)"
  [ "${result}" -eq 1 ]
}

@test "Listening on ports 8200, 8201" {
  [ "$(netstat -peanut | grep vault | awk '{print $4}' | awk -F':' '{print $NF}' | grep 8200)" ]
  [ "$(netstat -peanut | grep vault | awk '{print $4}' | awk -F':' '{print $NF}' | grep 8201)" ]
}

@test "Good response from /sys/health endpoint" {
  local endpoint="http://$(netstat -peanut | grep vault | awk '{print $4}' | grep 8200)/v1/sys/health"
  run curl -s -o /dev/null -w "%{http_code}" "${endpoint}"
  [ "$output" = "200" ]
  local health="$(curl -s ${endpoint})"
  local initialized_result="$(echo "${health}" | jq '.initialized == true')"
  [ "${initialized_result}" = "true" ]
  local sealed_result="$(echo "${health}" | jq '.sealed == false')"
  [ "${sealed_result}" = "true" ]
  local version_result="$(echo "${health}" | jq -r '.version')"
  [ "${version_result}" = "${pkg_version}" ]
}
