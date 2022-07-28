title 'Tests to confirm hugo works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'hugo')

control 'core-plans-hugo-works' do
  impact 1.0
  title 'Ensure hugo works as expected'
  desc '
  Verify hugo by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  ["hugo"].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /hugo v#{plan_pkg_version}/ }
    end
  end
end
