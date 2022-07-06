title 'Tests to confirm AWS CLI works as expected'

plan_name = input('plan_name', value: 'aws-cli')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
version_check_allow_list = input('version_check_allow_list')
version_check_block_list = input('version_check_block_list')

control 'core-plans-aws-cli' do
  impact 1.0
  title 'Ensure AWS CLI is working as expected'
  desc '
  We first check that the AWS executable is present and then
  run the AWS CLI `--version` method to verify it is working.
  '
  
  aws = command("hab pkg path #{plan_ident}")
  describe aws do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end
  aws = "#{aws.stdout.strip}/bin/aws"

  describe file(aws) do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{aws} --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /aws-cli/ }
    its('exit_status') { should eq 0 }
  end
end

control 'core-plans-aws-binaries' do
  impact 1.0
  title 'Ensure binaries provided by aws-cli work as expected'
  desc '
  AWS CLI bundles many binaries as part of its .hart file.
  In order to test this binaries we will first check that they exist and then
  run the binaries to check their version to verify they are working.
  '

  pkg_path = command("hab pkg path #{plan_ident}")
  describe pkg_path do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end
  bin_directory = "#{pkg_path.stdout.strip}/bin/"
  
  # Arry of all binaries for existance check by union
  binary_checks = version_check_allow_list | version_check_block_list
  binary_checks.each do |binary|
    describe file("#{File.join(bin_directory, binary)}") do
      it { should exist }
      its('size') { should > 0 }
      it { should be_executable }
    end
  end

  version_check_allow_list.each do |binary|
    describe command("#{File.join(bin_directory, binary)} --version") do
      its('stdout') { should_not be_empty }
      its('exit_status') { should eq 0 }
    end
  end
end
