title 'Tests to confirm mg exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'mg')

control 'core-plans-mg-exists' do
  impact 1.0
  title 'Ensure mg exists'
  desc '
  Verify mg by ensuring bin/mg exists'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/mg')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  describe file(command_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
