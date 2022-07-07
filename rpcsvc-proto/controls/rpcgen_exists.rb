title 'Tests to confirm the rpcgen binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "rpcsvc-proto")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-rpcgen-exists' do
  impact 1.0
  title 'Ensure the rpcgen binary exists'
  desc '
  To test that the rpcgen binary exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/rpcgen
      /hab/pkgs/core/rpcsvc-proto/1.4.2/20211022044623/bin/rpcgen
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  rpcgen_exists = command("ls -al #{File.join(bin_dir, "rpcgen")}")
  describe rpcgen_exists do
    its('stdout') { should match /rpcgen/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
