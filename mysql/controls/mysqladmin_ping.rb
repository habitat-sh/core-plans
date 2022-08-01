mysql_local_connection_string = attribute('mysql_local_connection_string', default: '--defaults-extra-file=/hab/svc/mysql/config/client.cnf')

describe bash("mysqladmin #{mysql_local_connection_string} ping") do
  its('stdout') { should match /mysqld is alive/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
