title 'Tests to confirm python works as expected'

plan_name = input('plan_name')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')
allow_list = input('allow_list')
block_list = input('block_list')

control 'core-plans-python' do
  impact 1.0
  title 'Ensure python works'
  desc '
  For python we check that the version is correctly returned e.g.

    $ python --version
    Python 3.7.0 (default, Mar 10 2020, 04:03:09)
    [GCC 9.1.0]

  As is often customary, we also say hello to the world with python:

    $ python -c "print(\'hello world\')"
    hello world
  '
  python_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe python_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  python_pkg_ident = python_pkg_ident.stdout.strip

  describe command("#{python_pkg_ident}/bin/python --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Python\s+#{python_pkg_ident.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{python_pkg_ident}/bin/python -c \"print('hello world')\"") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /hello world/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end

control 'core-plans-binaries' do
  impact 1.0
  title 'Ensure python works'
  desc '
  To check the binaries that python installs, we first locate the path where they are installed.
  Using this path we can then check that the binaries exist, are not empty and are executable.
  Then we run a version check to ensure the binary works and is of the correct version.
  '
  
  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  hab_pkg_path = hab_pkg_path.stdout.strip

  # All binaries to test
  binaries_to_test = allow_list | block_list
  binaries_to_test.each do |binary|
    describe file("#{hab_pkg_path}/bin/#{binary}") do
      it { should exist }
      it { should be_executable }
    end
  end

  allow_list.each do |binary|
    describe command("#{hab_pkg_path}/bin/#{binary} --version") do
      its('stdout') { should_not be_empty }
      its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end
end
