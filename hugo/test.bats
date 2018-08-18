source ./plan.sh

@test "Version matches" {
  result="$(hugo version | sed 's/.*v\([0-9.]\+\)\-.*/\1/')"
  [ "$result" = "${pkg_version}" ]
}

@test "Basic help" {
  run hugo help
  [ $status -eq 0 ]
}

@test "Create new site" {
  run hugo new site habtestsite
  [ $status -eq 0 ]
  [ -d habtestsite ]
  [ -f "habtestsite/config.toml" ]
  rm -rf habtestsite
}
