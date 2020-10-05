expected_version="$(echo $TEST_PKG_IDENT | cut -d/ -f3)"

@test "ruby runs" {
  run hab pkg exec $TEST_PKG_IDENT ruby -v
  [ $status -eq 0 ]
}

@test "is expected version ${expected_version}" {
  actual_version=$(hab pkg exec $TEST_PKG_IDENT ruby -v | grep -o 'ruby .*p')
  [ "${actual_version}" = "ruby ${expected_version}p" ]
}

@test "provides a gem command" {
  run hab pkg exec $TEST_PKG_IDENT gem env
  [ $status -eq 0 ]
}

@test "includes bundler" {
  run hab pkg exec $TEST_PKG_IDENT bundle -v
  [ $status -eq 0 ]
}

@test "unresolvable DNS returns SocketError with glibc's standard nsswitch.conf" {
  dns_error=$(hab pkg exec $TEST_PKG_IDENT ruby -r socket -e "
    begin
    Socket.pack_sockaddr_in(80, 'nope.example')
    rescue Exception => e
      p e.class.to_s
    end
  ")
  diff <( echo "$dns_error") <( echo '"SocketError"' )
}

@test "unresolvable DNS returns SocketError with myhostname plugin enabled (for RHEL-flavored hosts)" {
  # from RHEL's systemd-lib RPM spec %post action:
  #sed-fu to add myhostname to the hosts line of /etc/nsswitch.conf
  if [ -f /etc/nsswitch.conf ] ; then
    sed -i.bak -e '
    /^hosts:/ !b
    /\<myhostname\>/ b
    s/[[:blank:]]*$/ myhostname/
    ' /etc/nsswitch.conf >/dev/null 2>&1 || :
  fi
  dns_error=$(hab pkg exec $TEST_PKG_IDENT ruby -r socket -e "
    begin
    Socket.pack_sockaddr_in(80, 'nope.example')
    rescue Exception => e
      p e.class.to_s
    end
  ")
  mv /etc/nsswitch.conf.bak /etc/nsswitch.conf
  diff <( echo "$dns_error") <( echo '"SocketError"' )
}
