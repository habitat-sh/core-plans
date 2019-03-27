# Usage: wait_listen <protocol> <port> [wait-duration]
# protocol: tcp or udp
# port: int
# wait-duration: time in seconds

wait_listen() {
  local proto="-z"
  if [ "${1}" == "udp" ]; then
    proto="-u"
  fi
  local wait=${3:-1}
  while ! nc "${proto}" -w"${wait}" 127.0.0.1 "${2}"; do
    sleep 1
  done
}
