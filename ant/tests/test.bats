@test "Version matches" {
  version="$(echo ${PKGIDENT} | cut -d/ -f3)"
  result="$(hab pkg exec "${PKGIDENT}" ant -version | awk '{print $4}')"
  [ "$result" = "${version}" ]
}
