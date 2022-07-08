title 'Tests to confirm automake works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'automake')

control 'core-plans-automake-works' do
  impact 1.0
  title 'Ensure automake works as expected'
  desc '
  Verify automake by ensuring that
  (1) its installation directory exists 
  (2) binaries return the expected version
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end
  
  automake_full_path = File.join(plan_installation_directory.stdout.strip, "bin/automake")
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{automake_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /automake \(GNU automake\) #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
  end

  aclocal_full_path = File.join(plan_installation_directory.stdout.strip, "bin/aclocal")
  describe command("#{aclocal_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /aclocal \(GNU automake\) #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
  end
end
