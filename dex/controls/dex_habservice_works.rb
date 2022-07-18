title 'Tests to confirm dex habitat service works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'dex')

control 'core-plans-dex-habservice-works' do
  impact 1.0
  title 'Ensure dex habitat service works as expected'
  desc '
  Verify dex habitat service by ensuring that
  (1) the default.dex habitat service is "up";
  (2) the dex process is LISTENing on the expected port.  Note the
  regex that detects the LISTENing <program> works in both a habitat studio environment
  and a docker one.  In studio the program is displayed as "1234/dex";
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

  netstat_fullpath = File.join(netstat_installation_directory.stdout.strip, "bin/netstat" )
  listening_port=input('listening_port', value: '5556')
  describe command("#{netstat_fullpath} -peanut") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /:(?<port>#{listening_port}).*LISTEN\s+(?<program>-|\d+\/dex)/ }
    its('stderr') { should be_empty }
  end
end
