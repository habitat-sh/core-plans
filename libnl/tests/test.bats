source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Commands are on path" {
  commands=(
    genl-ctrl-list
    nl-class-add
    nl-class-delete
    nl-class-list
    nl-classid-lookup
    nl-cls-add
    nl-cls-delete
    nl-cls-list
    nl-link-list
    nl-pktloc-lookup
    nl-qdisc-add
    nl-qdisc-delete
    nl-qdisc-list
  )
  for c in "${commands[@]}"; do
    [ "$(command -v ${c})" ]
  done
}

@test "Version matches" {
  result="$(nl-link-list -v | head -1 | awk '{print $NF}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help command" {
  run nl-link-list --help
  [ $status -eq 0 ]
}

@test "Basic interface listing" {
  run nl-link-list
  [ $status -eq 0 ]
}
