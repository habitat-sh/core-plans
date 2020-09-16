@test "Dejagnu runtest isn't missing dependencies" {
  # This exercices the cli to determine if there are any
  # missing dependencies, such as `sed` or `expr`
  run /bin/hab pkg exec $pkg_ident runtest --help
  [ "$status" -eq 0 ]
}
