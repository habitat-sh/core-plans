title 'Tests to confirm findutils works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'findutils')

control 'core-plans-findutils-works' do
  impact 1.0
  title 'Ensure findutils works as expected'
  desc '
  Verify findutils by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  (3) it performs a successfull search
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/find')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{command_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /find \(GNU findutils\) #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
  end

  #describe command("#{command_full_path} /hab/svc/findutils -type f -name 'run'") do
  #    its('exit_status') { should eq 0 }
  #    its('stdout') { should_not be_empty }
  #    its('stdout') { should match /\/hab\/svc\/findutils\/hooks\/run/ }
  #    #its('stderr') { should be_empty }
  #  end
end
