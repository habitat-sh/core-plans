title 'Tests to confirm python-minimal works as expected'

plan_name = input('plan_name', value: 'python-minimal')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-python-minimal' do
  impact 1.0
  title 'Ensure python-minimal works'
  desc '
  For python we check that the version is correctly returned e.g.

    $ python --version
    Python 3.8.3

  As is often customary, we also say hello to the world with python:

    $ python -c "print(\'hello world\')"
    hello world
  '
  python_pkg_ident = command("hab pkg path #{plan_ident}")
  describe python_pkg_ident do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end
  python_pkg_ident = python_pkg_ident.stdout.strip

  describe command("#{python_pkg_ident}/bin/python --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Python\s+#{python_pkg_ident.split('/')[5]}/ }
    its('exit_status') { should eq 0 }
  end

  describe command("#{python_pkg_ident}/bin/python -c \"print('hello world')\"") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /hello world/ }
    its('exit_status') { should eq 0 }
  end
end

control 'core-plans-binaries' do
  impact 1.0
  title 'Ensure python works'
  desc '
  To check the binaries that python installs, we first locate the path where they are installed.
  Using this path we can then check that the binaries exist.
  Then we run a version check to ensure the binary works and is of the correct version.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end
  hab_pkg_path = hab_pkg_path.stdout.strip

    describe file("#{hab_pkg_path}/bin/2to3") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/2to3 --help") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Usage: 2to3/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/2to3-3.10") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/2to3-3.10 --help") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Usage: 2to3/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/pydoc") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/pydoc") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /pydoc - the Python documentation tool/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/pydoc3") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/pydoc3") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /pydoc - the Python documentation tool/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/pydoc3.10") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/pydoc3.10") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /pydoc - the Python documentation tool/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/python") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/python-config") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python-config --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 1 }
  end

  describe file("#{hab_pkg_path}/bin/python3") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python3 --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/python3-config") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python3-config --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 1 }
  end

  describe file("#{hab_pkg_path}/bin/python3.10") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python3.10 --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/python3.10-config") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python3.10-config --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 1 }
  end

  describe file("#{hab_pkg_path}/bin/python3.10") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python3.10 --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 0 }
  end

  describe file("#{hab_pkg_path}/bin/python3.10-config") do
    it { should exist }
    its('size') { should > 0 }
    it { should be_executable }
  end

  describe command("#{hab_pkg_path}/bin/python3.10-config --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 1 }
  end
end
