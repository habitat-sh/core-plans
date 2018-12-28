source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(vgs --version 2> /dev/null | grep -e 'LVM version' | awk '{print $3}' | awk '{gsub("[(][^)]*[)]","")}1')"
  [ "$result" = "${pkg_version}" ]
}
