@test "spark service is running" {
  [ "$(hab svc status | grep "spark\.default" | awk '{print $4}' | grep up)" ]
}
