expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f 3)"

@test "free version is $expected_version" {
  run hab pkg exec $TEST_PKG_IDENT free --version
  [ "$output" = "free from procps-ng $expected_version" ]
}

@test "free runs" {
  run hab pkg exec $TEST_PKG_IDENT free
  [ $status -eq 0 ]
}

@test "pgrep runs" {
  run hab pkg exec $TEST_PKG_IDENT pgrep -v no_such_pids
  [ $status -eq 0 ]
}

@test "pidof runs" {
  run hab pkg exec $TEST_PKG_IDENT pidof pidof
  [ $status -eq 0 ]
}

@test "pkill runs" {
  run hab pkg exec $TEST_PKG_IDENT pkill -h
  [ $status -eq 0 ]
}

@test "pmap runs" {
  run hab pkg exec $TEST_PKG_IDENT pmap -h
  [ $status -eq 0 ]
}

@test "ps runs" {
  run hab pkg exec $TEST_PKG_IDENT ps
  [ $status -eq 0 ]
}

@test "pwdx runs" {
  run hab pkg exec $TEST_PKG_IDENT pwdx -h
  [ $status -eq 0 ]
}

@test "slaptop runs" {
  run hab pkg exec $TEST_PKG_IDENT slabtop -o
  [ $status -eq 0 ]
}

@test "sysctl runs" {
  run hab pkg exec $TEST_PKG_IDENT sysctl -a
  [ $status -eq 0 ]
}

@test "tload runs" {
  run hab pkg exec $TEST_PKG_IDENT tload -h
  [ $status -eq 0 ]
}

@test "top runs" {
  run hab pkg exec $TEST_PKG_IDENT top -h
  [ $status -eq 0 ]
}

@test "uptime runs" {
  run hab pkg exec $TEST_PKG_IDENT uptime
  [ $status -eq 0 ]
}

@test "vmstat runs" {
  run hab pkg exec $TEST_PKG_IDENT vmstat
  [ $status -eq 0 ]
}

@test "w runs" {
  run hab pkg exec $TEST_PKG_IDENT w
  [ $status -eq 0 ]
}

@test "watch runs" {
  run hab pkg exec $TEST_PKG_IDENT watch -h
  [ $status -eq 0 ]
}
