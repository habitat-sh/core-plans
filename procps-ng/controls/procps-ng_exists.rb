title 'Tests to confirm procps-ng exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'procps-ng')

control 'core-plans-procps-ng-exists' do
  impact 1.0
  title 'Ensure procps-ng exists'
  desc '
  Verify procps-ng by ensuring all binaries
  (1) exist and
  (2) are executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  [
    "free",
    "pgrep",
    "pidof",
    "pkill",
    "pmap",
    "ps",
    "pwdx",
    "slabtop",
    "sysctl",
    "tload",
    "top",
    "uptime",
    "vmstat",
    "w",
    "watch",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
