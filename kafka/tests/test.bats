@test "kafka service is running" {
  [ "$(hab svc status | grep "kafka\.default" | awk '{print $4}' | grep up)" ]
}

expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "kafka matches version ${expected_version}" {
  actual_version_array=($(cat "${SUP_LOG}" | grep --text -m 1 -oP "(?<=INFO Kafka version: )([^ ]*)"))
  diff <( echo "${actual_version_array[0]}") <(echo "${expected_version}")
}

@test "kafka can create topics" {
  export JAVA_HOME="$(hab pkg path core/corretto11)"
  run hab pkg exec "${TEST_PKG_IDENT}" kafka-topics.sh --create --bootstrap-server 127.0.0.1:9092 --replication-factor 1 --partitions 1 --topic test 2>/tmp/debug.err
  [[ "$output" =~ "Created topic test." ]]
  [ "$status" -eq 0 ]
}

@test "kafka producer can send messages" {
  export JAVA_HOME="$(hab pkg path core/corretto11)"
  run hab pkg exec "${TEST_PKG_IDENT}" kafka-console-producer.sh --bootstrap-server 127.0.0.1:9092 --topic test < kafka_messages
  [ "$status" -eq 0 ]
}

@test "kafka consumer can consume messages" {
  export JAVA_HOME="$(hab pkg path core/corretto11)"
  run hab pkg exec "${TEST_PKG_IDENT}"  kafka-console-consumer.sh --bootstrap-server 127.0.0.1:9092 --topic test --from-beginning --max-messages 1
  [[ "$output" =~ "This is a test message." ]]
  [ "$status" -eq 0 ]
}
