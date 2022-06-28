title 'Tests to confirm postgresql-client works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'postgresql-client')

control 'core-plans-postgresql-client-works' do
  impact 1.0
  title 'Ensure postgresql-client works as expected'
  desc '
  Verify postgresql-client by ensuring that
  (1) its installation directory exists 
  (2) all binaries return expected version or help usage
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  full_suite = {
    "clusterdb" => {},
    "createdb" => {},
    "createlang" => {},
    "createuser" => {},
    "dropdb" => {},
    "droplang" => {},
    "dropuser" => {},
    "pg_basebackup" => {},
    # pg_config is the one outlier that does't output version info same as others so testing help usage instead
    "pg_config" => {
      command_suffix: "--help",
      command_output_pattern: /usage:(\s+|.*)pg_config/i,
    },
    "pg_ctl" => {},
    "pg_dump" => {},
    "pg_dumpall" => {},
    "pg_isready" => {},
    "pg_receivexlog" => {},
    "pg_recvlogical" => {},
    "pg_restore" => {},
    "pgbench" => {},
    "psql" => {},
    "reindexdb" => {},
    "vacuumdb" => {},
  }
  
  # Use the following to pull out a subset of the above and test progressiveluy
  subset = full_suite.select { |key, value| key.to_s.match(/^[a-z].*$/) }
  
  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]}" : "--version"
    command_output_pattern = value[:command_output_pattern] || /#{binary_name}\s+\(PostgreSQL\)\s+#{plan_pkg_version}/i
  
    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} #{command_suffix}") do
      its('exit_status') { should eq 0 }
      its('stdout') { should match command_output_pattern }
    end
  end
end