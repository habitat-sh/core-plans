@test "Service is running" {
  [ "$(hab svc status | grep "rabbitmq\.default" | awk '{print $4}' | grep up)" ]
}

@test "Listening on port 4369, 5672, 25672" {
  result="$(netstat -peanut | grep 4369 | grep LISTEN)"
  [ "$?" -eq 0 ]
  result="$(netstat -peanut | grep 5672 | grep LISTEN)"
  [ "$?" -eq 0 ]
  result="$(netstat -peanut | grep 25672 | grep LISTEN)"
  [ "$?" -eq 0 ]
}
