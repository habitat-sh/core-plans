title 'Tests to confirm postgresql-client exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'postgresql-client')

control 'core-plans-postgresql-client-exists' do
  impact 1.0
  title 'Ensure postgresql-client exists'
  desc '
  Verify postgresql-client by ensuring bin/postgresql-client 
  (1) exists and
  (2) is executable'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "clusterdb",
    "createdb",
    "createlang",
    "createuser",
    "dropdb",
    "droplang",
    "dropuser",
    "pg_basebackup",
    "pg_config",
    "pg_ctl",
    "pg_dump",
    "pg_dumpall",
    "pg_isready",
    "pg_receivexlog",
    "pg_recvlogical",
    "pg_restore",
    "pgbench",
    "psql",
    "reindexdb",
    "vacuumdb",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
