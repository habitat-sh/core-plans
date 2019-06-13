@test "cert.pem contains a valid Mozilla certificate" {
  expected="Certificate data from Mozilla"
  error_message="ERROR: did not find the expected text below"
  actual="$(cat "/hab/pkgs/${TEST_PKG_IDENT}/ssl/cert.pem" | grep -o "${expected}" || echo "${error_message}")"
  diff <(echo "${actual}") <(echo "${expected}")
}
