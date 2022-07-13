@test "uuidgen produces known output" {
  run hab pkg exec $TEST_PKG_IDENT uuidgen --sha1 --namespace @dns --name "www.example.com"
  [ "$output" == "2ed6657d-e927-568b-95e1-2665a8aea6a2" ]
}

