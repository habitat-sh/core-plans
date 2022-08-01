mysql_local_connection_string = attribute('mysql_local_connection_string', default: '--defaults-extra-file=/hab/svc/mysql/config/client.cnf')

describe bash("mysqladmin #{mysql_local_connection_string} status") do
  its('stdout') { should match /Uptime/ }
  its('stdout') { should match /Threads/ }
  its('stdout') { should match /Open tables/ }
  its('stdout') { should match /Queries per second avg/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
