title 'Tests to confirm expat exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'expat')

control 'core-plans-expat-exists' do
  impact 1.0
  title 'Ensure expat exists'
  desc '
  Verify expat by ensuring bin/xmlwf exists'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/xmlwf')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  describe file(command_full_path) do
    it { should exist }
  end
end
