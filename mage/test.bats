source ./plan.sh

@test "Binlink dependencies" {
  run hab pkg binlink core/go
  [ $status -eq 0 ]

  run hab pkg binlink core/git
  [ $status -eq 0 ]
}

@test "Command is on path" {
  [ "$(command -v mage)" ]
}

@test "Version matches" {
  result="$(mage --version 2>&1 | head -1)"
  [ "${result}" = "Mage Build Tool v${pkg_version}" ]
}

@test "Help command" {
  run mage --help
  [ $status -eq 0 ]
}

@test "Mage init works" {
  [ ! -f magefile.go ]
  mage -init
  [ -f magefile.go ]
  rm -f magefile.go
}
