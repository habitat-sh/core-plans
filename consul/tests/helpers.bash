# Usage: test_listen <protocol> <port> [wait-duration]
# protocol: tcp or udp
# port: int
# wait-duration: time in seconds

get_ip_address() {
  ip route get 1 | awk '{print $NF;exit}'
}

check_ip() {
  if [ -z $1 ]
  then
    echo $(get_ip_address)
  else
    echo $1
  fi
}

test_listen() {
  local proto="-z"
  if [ "${1}" == "udp" ]; then
    proto="-u"
  fi
  local ip_address=$(check_ip $4)
  local wait=${3:-3}
  nc "${proto}" -w"${wait}" "${ip_address}" "${2}"
  return $?
}

wait_listen() {
  echo $4
  local proto="-z"
  if [ "${1}" == "udp" ]; then
    proto="-u"
  fi
  local ip_address=$(check_ip $4)
  local wait=${3:-1}
  while ! nc "${proto}" -w"${wait}" "${ip_address}" "${2}"; do
    sleep 1
  done
}
