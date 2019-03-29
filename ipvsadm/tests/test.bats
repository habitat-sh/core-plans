source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Commands are on path" {
  [ "$(command -v ipvsadm)" ]
  [ "$(command -v ipvsadm-restore)" ]
  [ "$(command -v ipvsadm-save)" ]
}

@test "Version matches" {
  result="$(ipvsadm --version | awk '{print $2}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Help Command Check" {
  run ipvsadm --help
  [ $status -eq 0 ]

  run ipvsadm-save -h
  [ "${lines[0]}" = "ipvsadm-save: Script to save the IPVS table to stdout." ]
  [ $status -eq 1 ]
}

@test "Display the ipvs table" {
  run ipvsadm --list
  [ $status -eq 0 ]
}
