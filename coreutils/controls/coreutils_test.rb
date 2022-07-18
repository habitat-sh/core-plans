title 'Tests to confirm coreutils works as coreutilsed'

plan_name = input('plan_name', value: 'coreutils')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-coreutils' do
  impact 1.0
  title 'Ensure coreutils works'
  desc '
  To test coreutils is working as expected, we choose a subset of executables that ship with the
  package and perform a few basic operations.  For example:

    $ whoami
    root

    $ ls -al <path to ls>/ls
    -rwxr-xr-x 1 root root 159272 Mar  5 23:19 <path to ls>/ls

    $ env
    <env listing>

    $ echo "hello world"
    hello world
  '
  coreutils_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe coreutils_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  coreutils_pkg_ident = coreutils_pkg_ident.stdout.strip

  describe command("ls -al #{coreutils_pkg_ident}/bin/ls") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{coreutils_pkg_ident}/}
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{coreutils_pkg_ident}/bin/whoami") do
    its('stdout') { should_not be_empty }
    #its('stdout') { should match /root/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{coreutils_pkg_ident}/bin/env") do
    its('stdout') { should_not be_empty }
    #its('stdout') { should match /PWD/ }
    #its('stdout') { should match /PATH/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{coreutils_pkg_ident}/bin/echo 'hello world'") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /hello\s+world/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
