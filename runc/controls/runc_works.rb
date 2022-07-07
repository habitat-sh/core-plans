title 'Tests to confirm runc works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'runc')

control 'core-plans-runc-works' do
  impact 1.0
  title 'Ensure runc works as expected'
  desc '
  Verify runc by ensuring that
  (1) its installation directory exists 
  (2) it returns the expected version
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  ["runc"].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{binary_name}\s+version\s+#{plan_pkg_version}/ }
    end
  end
end