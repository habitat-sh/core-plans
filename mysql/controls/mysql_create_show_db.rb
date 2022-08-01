mysql_local_connection_string = attribute('mysql_local_connection_string', default: '--defaults-extra-file=/hab/svc/mysql/config/client.cnf')
mysql_db_to_create = attribute('mysql_db_to_create', default: 'hab_inspec_db')

describe bash("mysqladmin #{mysql_local_connection_string} create #{mysql_db_to_create}; mysql #{mysql_local_connection_string} -e \"show databases;\"") do
  its('stdout') { should match /#{mysql_db_to_create}/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
