title 'Tests to confirm protobuf2 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'protobuf2')

control 'core-plans-protobuf2-works' do
  impact 1.0
  title 'Ensure protobuf2 works as expected'
  desc '
  Verify protobuf2 by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "protoc")
  describe command("#{command_full_path} --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /libprotoc #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
