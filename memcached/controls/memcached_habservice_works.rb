title 'Tests to confirm memcached habitat service works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'memcached')

control 'core-plans-memcached-habservice-works' do
  impact 1.0
  title 'Ensure memcached habitat service works as expected'
  desc '
  Verify memcached habitat service by ensuring that 
  (1) the default.memcached habitat service is "up"; 
  (2) the memcached process is LISTENing on the expected port.  Note the 
  regex that detects the LISTENing <program> works in both a habitat studio environment
  and a docker one.  In studio the program is displayed as "1234/memcached";
  whereas in docker as "-".
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end

  plan_pkg_ident = ((plan_installation_directory.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  describe command("hab svc status") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /(?<package>#{plan_pkg_ident})\s+(?<type>standalone)\s+(?<desired>up)\s+(?<state>up)/ }
    its('stderr') { should be_empty }
  end

  netstat_installation_directory = command("hab pkg path core/busybox-static")
  describe netstat_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end

  netstat_fullpath = File.join(netstat_installation_directory.stdout.strip, "bin", "netstat" )
  listening_port=input('listening_port', value: '11211')
  describe command("#{netstat_fullpath} -peanut") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /:(?<port>#{listening_port}).*LISTEN\s+(?<program>-|\d+\/memcached)/ }
    its('stderr') { should be_empty }
  end
end
