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
  jq -ne --argjson doc "$(curl http://127.0.0.1:5556/dex/.well-known/openid-configuration)" \
    '$doc.issuer | test("https://localhost/dex")'
}

@test "'dex version' returns the correct version" {
  hab pkg exec "${TEST_PKG_IDENT}" dex version | grep -q "dex Version: v${pkg_version}"
}
