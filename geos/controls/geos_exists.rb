title 'Tests to confirm geos exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'geos')

control 'core-plans-geos-exists' do
  impact 1.0
  title 'Ensure geos exists'
  desc '
  Verify geos by ensuring bin/geos-config exists'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/geos-config')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  describe file(command_full_path) do
    it { should exist }
  end
end
