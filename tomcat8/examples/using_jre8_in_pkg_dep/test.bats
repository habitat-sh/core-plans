source "${BATS_TEST_DIRNAME}/../../plan.sh"

@test "package directory for package ident ${TEST_PKG_IDENT} exists" {
  [ -d "/hab/pkgs/${TEST_PKG_IDENT}" ]
}

@test "tomcat8.default habitat service should be running" {
  [ "$(hab svc status | grep "tomcat8\.default" | awk '{print $4}' | grep up)" ]
}

@test "curl -sS localhost:8080 should return correct version ${pkg_version}" {
  actual="$( curl -sS localhost:8080 2>&1  |  grep -Eo "8\.5\.9" | uniq )"
  diff <( echo "${actual}"  ) <( echo "${pkg_version}")
}
