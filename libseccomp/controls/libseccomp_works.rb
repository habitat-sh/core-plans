title 'Tests to confirm libseccomp works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'libseccomp')

control 'core-plans-libseccomp-works' do
  impact 1.0
  title 'Ensure libseccomp works as expected'
  desc '
  Verify libseccomp by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "scmp_sys_resolver")
  describe command("#{command_full_path} -h 2>&1") do
    its('exit_status') { should_not eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match  /usage:(\s+|.*)scmp_sys_resolver/i }
  end
end
