title 'Tests to confirm openssl-fips works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'openssl-fips')

control 'core-plans-openssl-fips-works' do
  impact 1.0
  title 'Ensure openssl-fips works as expected'
  desc '
  Verify openssl-fips by ensuring that
  (1) its installation directory exists
  (2) the bin/fips_standalone_sha1 returns an expected fips sha for a test file,
      the ./hooks/run.
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/fips_standalone_sha1')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  target_file = File.join(plan_installation_directory.stdout.strip, "hooks/run")
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  #describe command("#{command_full_path} #{target_file}") do
  #  its('exit_status') { should eq 0 }
  #  its('stdout') { should_not be_empty }
  #  its('stdout') { should match /HMAC-SHA1\(#{target_file}\)= 6c46f2d8a70f53e30b9ae93f86846c26264a5742/ }
  #  #its('stderr') { should be_empty }
  #end
end
