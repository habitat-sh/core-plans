title 'Tests to confirm zeromq works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'zeromq')

control 'core-plans-zeromq-works' do
  impact 1.0
  title 'Ensure zeromq works as expected'
  desc '
  Verify zeromq by ensuring that
  (1) its installation directory exists 
  (2) curve_keygen returns expected output
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "curve_keygen")
  describe command("#{command_full_path}") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /\=\= CURVE PUBLIC KEY \=\=/ }
    #its('stderr') { should be_empty }
  end
end
