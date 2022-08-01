title 'Tests to confirm bison works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'bison')

control 'core-plans-bison-works' do
  impact 1.0
  title 'Ensure bison works as expected'
  desc '
  Verify bison by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  bison_full_path = File.join(plan_installation_directory.stdout.strip, "bin/bison")
  describe command("#{bison_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /bison \(GNU Bison\) #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
  end

  yacc_full_path = File.join(plan_installation_directory.stdout.strip, "bin/yacc")
  describe command("#{yacc_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /bison \(GNU Bison\) #{plan_pkg_version}/ }
    #its('stderr') { should be_empty }
  end
end
