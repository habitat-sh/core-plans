source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(goaccess --version | head -1 | awk '{print $3}')"
  [ "${result::-1}" = "${pkg_version}" ]
}

@test "Parse nginx combined log entry" {
  run goaccess --log-format=COMBINED --output csv <<-EOF
	10.90.8.3 - - [28/Nov/2018:18:39:03 +0000] "GET / HTTP/1.1" 403 572 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36"
EOF

  [ $status -eq 0 ]
  [ "${lines[1]//$'\r'}" = '"1",,"general",,,,,,,,"1","total_requests"' ]
  [ "${lines[2]//$'\r'}" = '"2",,"general",,,,,,,,"1","valid_requests"' ]
}
