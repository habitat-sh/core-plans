title 'Tests to confirm protobuf2 exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'protobuf2')

control 'core-plans-protobuf2-exists' do
  impact 1.0
  title 'Ensure protobuf2 exists'
  desc '
  Verify protobuf2 by ensuring bin/protoc
  (1) exists and
  (2) is executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
    #its('stderr') { should be_empty }
  end

  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "protoc")
  describe file(command_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
