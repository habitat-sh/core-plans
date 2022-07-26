title 'Tests to confirm the grep binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "{}")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-grep-exists' do
  impact 1.0
  title 'Ensure the grep binary exists'
  desc '
  To test that the grep binary exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/grep
      -rwxr-xr-x 1 root root 285864 Mar  5 23:28 /hab/pkgs/core/grep/3.3/20200305232635/bin/grep
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  grep_exists = command("ls -al #{File.join(bin_dir, "grep")}")
  describe grep_exists do
    its('stdout') { should match /grep/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  fgrep_exists = command("ls -al #{File.join(bin_dir, "fgrep")}")
  describe fgrep_exists do
    its('stdout') { should match /fgrep/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  egrep_exists = command("ls -al #{File.join(bin_dir, "egrep")}")
  describe egrep_exists do
    its('stdout') { should match /egrep/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
