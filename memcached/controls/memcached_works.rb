title 'Tests to confirm memcached works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'memcached')

control 'core-plans-memcached-works' do
  impact 1.0
  title 'Ensure memcached works as expected'
  desc '
  Verify memcached by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  (3) it can --enable-ssl; 
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]

  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "memcached")
  describe command("#{command_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /memcached #{plan_pkg_version}/ }
    its('stderr') { should be_empty }
  end

  describe command("#{command_full_path} --help | grep 'enable-sasl'") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /--enable-sasl\s+turn on Sasl authentication/ }
    its('stderr') { should be_empty }
  end
end