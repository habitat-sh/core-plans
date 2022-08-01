title 'Tests to confirm libbsd libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libbsd")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libbsd' do
  impact 1.0
  title 'Ensure libbsd libraries exist as expected'
  desc '
  In order to test that the libraries that libbsd exist, we must first fine the package path.
  Using the package path we ensure that the directories that it is meant to create, have been created
    $ ls -al $PKG_PATH/include/
      total 12
      drwxr-xr-x 3 root root 4096 Mar  6 01:57 .
      drwxr-xr-x 5 root root 4096 Mar  6 01:57 ..
      drwxr-xr-x 4 root root 4096 Mar  6 01:57 bsd
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
