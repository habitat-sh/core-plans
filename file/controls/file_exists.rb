title 'Tests to confirm the file binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "file")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-file-exists' do
  impact 1.0
  title 'Ensure the file binary exists'
  desc '
  To test that the file binary exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/file
      . .. /hab/pkgs/core/file/5.37/20200305174635/bin/file
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  file_exists = command("ls -al #{File.join(bin_dir, "file")}")
  describe file_exists do
    its('stdout') { should match /file/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
