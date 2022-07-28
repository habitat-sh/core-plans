title 'Tests to confirm procps-ng works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'procps-ng')

control 'core-plans-procps-ng-works' do
  impact 1.0
  title 'Ensure procps-ng works as expected'
  desc '
  Verify procps-ng by ensuring that
  (1) its installation directory exists
  (2) all binaries return the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  # check version on all binaries apart from 'top'
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
    "uptime",
    "vmstat",
    "w",
    "watch",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{binary_name} from procps-ng #{plan_pkg_version}/ }
      #its('stderr') { should be_empty }
    end
  end

  # check 'top' separately because it works differently from the others
  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "top")
  describe command("#{command_full_path} -v") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /procps-ng #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
  end
end
