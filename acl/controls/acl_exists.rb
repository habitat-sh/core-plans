title 'Tests to confirm acl exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'acl')

control 'core-plans-acl-exists' do
  impact 1.0
  title 'Ensure acl exists'
  desc '
  Verify acl by ensuring bin/getfacl exists'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/getfacl')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  describe file(command_full_path) do
    it { should exist }
  end
end
