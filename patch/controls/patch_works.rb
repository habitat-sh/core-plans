title 'Tests to confirm patch works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'patch')

control 'core-plans-patch-works' do
  impact 1.0
  title 'Ensure patch works as expected'
  desc '
  Verify patch by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/patch')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{command_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /GNU patch #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
  end
end
