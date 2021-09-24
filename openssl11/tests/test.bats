TEST_PKG_VERSION="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
HAB_PKGS_PATH="/hab/pkgs"
CORE_CACERTS_IDENT="$(grep 'core/cacerts' "${HAB_PKGS_PATH}/${TEST_PKG_IDENT}/TDEPS")"
CORE_CACERTS_SSL_PATH="${HAB_PKGS_PATH}/${CORE_CACERTS_IDENT}/ssl"


@test "Version matches" {
  result="$(hab pkg exec "${TEST_PKG_IDENT}" openssl version | awk '{print $2}')"
  [ "$result" = "${TEST_PKG_VERSION}" ]
}

@test "OPENSSLDIR set to core/cacerts" {
  result=$(hab pkg exec "${TEST_PKG_IDENT}" openssl version -a | grep 'OPENSSLDIR:' | sed 's/.*\"\(.*\)\"$/\1/' )
  [ "$result" = "${CORE_CACERTS_SSL_PATH}" ]
}
