title 'Tests to confirm gdbm exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'gdbm')

control 'core-plans-gdbm-exists' do
  impact 1.0
  title 'Ensure gdbm exists'
  desc '
  Verify gdbm by ensuring bin/gdbmtool exists'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/gdbmtool')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  describe file(command_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
