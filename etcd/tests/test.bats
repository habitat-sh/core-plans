source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="v$(etcdctl version | grep 'etcdctl version:' | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}
