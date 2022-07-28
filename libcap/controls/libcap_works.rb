title 'Tests to confirm libcap binaries work as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libcap")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libarchive' do
  impact 1.0
  title 'Ensure libcap binaries are working as expected'
  desc '
  To test the binaries that libcap provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the binary can execute a help or similar command.
    $ $PKG_PATH/bin/capsh --help
      usage: capsh [args ...]
      --help         this message (or try \'man capsh\')
      ...
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  capsh_exists = command("ls #{File.join(bin_dir, "capsh")}")
  describe capsh_exists do
    its('stdout') { should match /capsh/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  capsh_works = command("#{File.join(bin_dir, "capsh")} --help")
  describe capsh_works do
    its('stdout') { should match /usage: #{File.join(bin_dir, "capsh")}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  libcap_exists = command("ls #{File.join(bin_dir, "getcap")}")
  describe libcap_exists do
    its('stdout') { should match /getcap/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  getcap_works = command("#{File.join(bin_dir, "getcap")} -h")
  describe getcap_works do
    its('stdout') { should be_empty }
    #its('stderr') { should match /usage: getcap/ }
    its('exit_status') { should eq 0 }
  end
  getpcaps_exists = command("ls #{File.join(bin_dir, "getpcaps")}")
  describe getpcaps_exists do
    its('stdout') { should match /getpcaps/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  getpcaps_works = command("#{File.join(bin_dir, "getpcaps")}")
  describe getpcaps_works do
    its('stdout') { should be_empty }
    #its('stderr') { should match /usage: getcaps/ }
    its('exit_status') { should eq 1 }
  end

  setcap_exists = command("ls #{File.join(bin_dir, "setcap")}")
  describe setcap_exists do
    its('stdout') { should match /setcap/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  setcap_works = command("#{File.join(bin_dir, "setcap")} --help")
  describe setcap_works do
    its('stdout') { should be_empty }
    #its('stderr') { should match /usage: setcap/ }
    its('exit_status') { should eq 1 }
  end

end
