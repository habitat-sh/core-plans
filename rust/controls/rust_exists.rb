title 'Tests to confirm rust exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'rust')

control 'core-plans-rust-exists' do
  impact 1.0
  title 'Ensure rust exists'
  desc '
  Verify rust by ensuring bin/rustc exists'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    # its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/rustc')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  describe file(command_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
