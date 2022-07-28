title 'Tests to confirm the curl binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "curl")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-curl-exists' do
  impact 1.0
  title 'Ensure the curl binary exists'
  desc '
  To test that the curl & curl-config binaries exist we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/curl
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  curl_exists = command("ls #{File.join(bin_dir, "curl")}")
  describe curl_exists do
    its('stdout') { should match /curl/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  curl_config_exists = command("ls #{File.join(bin_dir, "curl-config")}")
  describe curl_config_exists do
    its('stdout') { should match /curl-config/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
