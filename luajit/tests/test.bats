source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result=$(luajit -v | awk '{print $2}')
  [ "$result" = "${pkg_version}" ]
}

@test "Hello World" {
  result=$(luajit -e 'print("Hello Habitat")')
  [ "$result" = "Hello Habitat" ]
}
