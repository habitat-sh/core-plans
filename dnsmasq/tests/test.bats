@test "dnsmasq service is running" {
  [ "$(hab svc status | grep "dnsmasq\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "dnsmasq successfully finds debian.org" {
  run nslookup debian.org 127.0.0.1
  diff <( echo "${status}") <( echo "0")
}

@test "dnsmasq binary matches version ${expected_version}" {
  actual_version="$(hab pkg exec "${TEST_PKG_IDENT}" dnsmasq -- --version | grep "Dnsmasq version" | awk '{print $3}')"
  diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}

@test "dnsmasq binary test returns success" {
  actual="$(hab pkg exec "${TEST_PKG_IDENT}" dnsmasq -- --test 2>&1)"
  diff <( echo "$actual" ) <( echo "dnsmasq: syntax check OK." )
}
