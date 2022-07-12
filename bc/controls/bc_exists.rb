title 'Tests to confirm bc exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'bc')

control 'core-plans-bc-exists' do
  impact 1.0
  title 'Ensure bc exists'
  desc '
  Verify bc by ensuring bin/bc exists'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/bc')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  describe file(command_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
