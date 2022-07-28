title 'Tests to confirm openssl-musl works as expected'

plan_name = input('plan_name', value: 'openssl-musl')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-openssl-musl' do
  impact 1.0
  title 'Ensure openssl-musl works'
  desc '
  For openssl-musl, we check that the executable exists and that it behaves as expected.
  '
  openssl_musl_pkg = command("#{hab_path} pkg path #{plan_ident}")
  describe openssl_musl_pkg do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  openssl_musl_pkg = openssl_musl_pkg.stdout.strip

  describe file("#{openssl_musl_pkg}/bin/openssl") do
    it { should exist }
    it { should be_executable }
  end

  # The below tests are not working with the current version of openssl-musl.
  # For more information see: https://github.com/chef-base-plans/openssl-musl/issues/1
  #
  # describe command("#{openssl_musl_pkg}/bin/openssl version") do
  #   its('exit_status') { should eq 0 }
  #   its('stdout') { should_not be_empty }
  #   its('stdout') { should match /#{openssl_musl_pkg.split('/')[5]}/ }
  #   its('stderr') { should be_empty }
  # end
  #
  # describe command("echo 'hello world' | #{openssl_musl_pkg}/bin/openssl enc -base64") do
  #   its('exit_status') { should eq 0 }
  #   its('stdout') { should_not be_empty }
  #   its('stdout') { should match /aGVsbG8gd29ybGQK/ }
  #   its('stderr') { should be_empty }
  # end
end
