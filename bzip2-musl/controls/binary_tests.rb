title 'Tests to confirm bzip2-musl binaries works as expected'

plan_name = input('plan_name', value: 'bzip2-musl')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-bzip2-musl-binaries' do
  impact 1.0
  title 'Ensure bzip2-musl binaries work'
  desc '
  We confirm that the bzip2-musl binaries are present in the expected location.

    $ ls -al <pkg>/bin/bzip2

  Next, we test for simple execution working:

    $ bzip2 --version
  '

  pkg_path = command("hab pkg path #{plan_ident}")
  describe pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  binary_directory = File.join(pkg_path.stdout.strip, "/bin/")

  version = pkg_path.stdout.strip.split('/')[5]

  describe file("#{File.join(binary_directory, "bzip2recover")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzip2recover")} --version") do
    #its('stderr') { should match /bzip2recover #{version}/ }
    its('exit_status') { should eq 1 }
  end

  describe file("#{File.join(binary_directory, "bzgrep")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzgrep")}") do
    its('stdout') { should match /grep through bzip2 files/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 1 }
  end

  describe file("#{File.join(binary_directory, "bzdiff")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzdiff")}") do
    its('stdout') { should match /Usage: bzdiff/ }
    its('exit_status') { should eq 1 }
  end

  describe file("#{File.join(binary_directory, "bunzip2")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bunzip2")} --version") do
    its('stdout') { should be_empty }
    #its('stderr') { should match /Version #{version}/ }
    its('exit_status') { should eq 2 }
  end

  describe file("#{File.join(binary_directory, "bzmore")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzmore")} --version") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should match /Version #{version}/ }
    its('exit_status') { should eq 1 }
  end

  describe file("#{File.join(binary_directory, "bzless")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzless")} --version") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should match /Version #{version}/ }
    its('exit_status') { should eq 1 }
  end

  describe file("#{File.join(binary_directory, "bzegrep")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzegrep")}") do
    its('stdout') { should match /grep through bzip2 files/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 1 }
  end

  describe file("#{File.join(binary_directory, "bzcat")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzcat")} --version") do
    its('stdout') { should be_empty }
    #its('stderr') { should match /Version #{version}/ }
    its('exit_status') { should eq 2 }
  end

  describe file("#{File.join(binary_directory, "bzip2")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzip2")} --version") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should match /Version #{version}/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{File.join(binary_directory, "bzfgrep")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzfgrep")}") do
    its('stdout') { should match /grep through bzip2 files/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 1 }
  end

  describe file("#{File.join(binary_directory, "bzcmp")}") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{File.join(binary_directory, "bzcmp")}") do
    its('stdout') { should match /Usage: bzcmp/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 1 }
  end
end
