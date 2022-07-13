title 'Tests to confirm iproute2 exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'iproute2')

control 'core-plans-iproute2-exists' do
  impact 1.0
  title 'Ensure iproute2 exists'
  desc '
  Verify iproute2 by ensuring bin/iproute2 
  (1) exists and
  (2) is executable'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "bridge",
    "ctstat",
    "genl",
    "ifcfg",
    "ifstat",
    "ip",
    "lnstat",
    "nstat",
    "routef",
    "routel",
    "rtacct",
    "rtmon",
    "rtpr",
    "rtstat",
    "ss",
    "tc",
  ].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "sbin", binary_name)
      describe file(command_full_path) do
        it { should exist }
        it { should be_executable }
      end
    end
end
