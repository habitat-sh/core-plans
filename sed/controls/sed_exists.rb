title 'Tests to confirm the sed binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "sed")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-sed-exists' do
  impact 1.0
  title 'Ensure the sed binary exists'
  desc '
  To test that the sed binary exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/sed
      -rwxr-xr-x 1 root root 138504 Mar  5 23:10 /hab/pkgs/core/sed/4.5/20200305230928/bin/sed
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  sed_exists = command("ls -al #{File.join(bin_dir, "sed")}")
  describe sed_exists do
    its('stdout') { should match /sed/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
