#!/bin/bash

@test "Help command" {
  run hab pkg exec "${TEST_PKG_IDENT}" sed --help
  [ $status -eq 0 ]
}

substitute_command() {
  echo 'catdogcat' | hab pkg exec "${TEST_PKG_IDENT}" sed s/dog/cat/g
}
@test "Basic text substitution" {
  run substitute_command
  [ "$status" -eq 0 ]
  [ "$output" = 'catcatcat' ]
}
