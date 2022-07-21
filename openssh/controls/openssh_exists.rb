title 'Tests to confirm openssh exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'openssh')

control 'core-plans-openssh-exists' do
  impact 1.0
  title 'Ensure openssh exists'
  desc '
  Verify openssh by ensuring all binaries (bin, sbin, and libexec) 
  (1) exist
  (2) are executable'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end

  # sbin binary (sshd only)
  command_full_path = File.join(plan_installation_directory.stdout.strip, "sbin", "sshd")
  describe file(command_full_path) do
    it { should exist }
    it { should be_executable }
  end

  # bin binaries
  [
    "scp",
    "sftp",
    "ssh",
    "ssh-add",
    "ssh-agent",
    "ssh-keygen",
    "ssh-keyscan",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end

  # libexec binaries
  [
    "sftp-server",
    "ssh-keysign",
    "ssh-pkcs11-helper",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "libexec", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
