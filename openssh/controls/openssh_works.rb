title 'Tests to confirm openssh works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'openssh')

control 'core-plans-openssh-works' do
  impact 1.0
  title 'Ensure openssh works as expected'
  desc '
  Verify openssh by ensuring that
  (1) the installation directory exists 
  (2) sbin/sshd returns the expected version
  (3) all other binaries return expected output except for "ssh-pkcs11-helper",
      which is not included in the verifications below: ssh-pkcs11-helper
      does not return any output and, as the man page explains:  it "is 
      not intended to be invoked by the user, but from ssh-agent" 
      (https://man7.org/linux/man-pages/man8/ssh-pkcs11-helper.8.html)
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end
  
  # sbin/sshd returns expected version
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  command_full_path = File.join(plan_installation_directory.stdout.strip, "sbin", "sshd")
  describe command("#{command_full_path} -V") do
    its('exit_status') { should_not eq 0 }
    its('stdout') { should be_empty }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /^OpenSSH_#{plan_pkg_version}/ }
  end

  # bin/ssh-add returns a warning because no ssh-agent running
  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "ssh-add")
  describe command("#{command_full_path} --help") do
    its('exit_status') { should_not eq 0 }
    its('stdout') { should be_empty }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /(?<warning>Could not open a connection to your authentication agent)/ }
  end

  # bin/ssh-keysign returns a warning
  command_full_path = File.join(plan_installation_directory.stdout.strip, "libexec", "ssh-keysign")
  describe command("#{command_full_path} --help") do
    its('exit_status') { should_not eq 0 }
    its('stdout') { should be_empty }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /(?<warning>ssh-keysign not enabled in)\s+\S+(?=ssh_config)/ }
  end

  # bin binaries return 'usage' output
  [
    "scp",
    "sftp",
    "ssh",
    "ssh-agent",
    "ssh-keygen",
    "ssh-keyscan",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --help") do
      its('exit_status') { should_not eq 0 }
      its('stdout') { should be_empty }
      its('stderr') { should_not be_empty }
      its('stderr') { should match /usage:\s+#{binary_name}/ }
    end
  end

  # libexec binary returns 'usage' output
  command_full_path = File.join(plan_installation_directory.stdout.strip, "libexec", "sftp-server")
  describe command("#{command_full_path} --help") do
    its('exit_status') { should_not eq 0 }
    its('stdout') { should be_empty }
    its('stderr') { should_not be_empty }
    its('stderr') { should match /usage:\s+sftp-server/ }
  end
end