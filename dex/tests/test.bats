source "${BATS_TEST_DIRNAME}/../plan.sh"
load helpers

@test "Port Listen TCP/5556" {
  test_listen tcp 5556
  [ "$?" -eq 0 ]
}

@test "/dex/healthz endpoint returns success" {
  curl -f http://127.0.0.1:5556/dex/healthz
}

@test "OpenID Connect discovery document is returned with issuer set" {
  curl http://127.0.0.1:5556/dex/.well-known/openid-configuration |
    jq -e '.issuer | test("https://localhost/dex")'
}
