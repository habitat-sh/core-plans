source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(curl -s http://localhost:8153/go/admin/pipeline/new?group=defaultGroup| grep data-version-go-version | tr -d [:lower:],=,'"',-)"
  [ "$result" = "${pkg_version}" ]
}
