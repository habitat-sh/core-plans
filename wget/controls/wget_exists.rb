title 'Tests to confirm the wget binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "wget")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-wget-exists' do
  impact 1.0
  title 'Ensure the wget binary exists'
  desc '
  To test that the wget binary exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/wget
      /hab/pkgs/core/wget/1.19.5/20200306010801/bin/wget
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  wget_exists = command("ls -al #{File.join(bin_dir, "wget")}")
  describe wget_exists do
    its('stdout') { should match /wget/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
