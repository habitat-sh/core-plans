title 'Tests to confirm the tar binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "tar")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-tar-exists' do
  impact 1.0
  title 'Ensure the tar binary exists'
  desc '
  To test that the tar binary exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/tar
      /hab/pkgs/core/tar/1.32/20200305233447/bin/tar
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  tar_exists = command("ls -al #{File.join(bin_dir, "tar")}")
  describe tar_exists do
    its('stdout') { should match /tar/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
