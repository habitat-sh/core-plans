source ./plan.sh

@test "Version matches" {
  result="$(terraform version | head -1 | awk '{print $2}')"
  [ "$result" = "v${pkg_version}" ]
}

@test "Terraform default workspace" {
  run terraform workspace list
  [ $status -eq 0 ]
  [ "${lines[0]}" = "* default" ]
}
