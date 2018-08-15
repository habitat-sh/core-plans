source ./plan.sh

@test "Version matches" {
  result="$(strace -V | head -1 | awk '{print $4}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Can strace" {
  run strace strace -h
  [ $status -eq 0 ]
}
