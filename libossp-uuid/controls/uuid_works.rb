title 'Tests to confirm uuid & uuid-config binaries work as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libossp-uuid")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libossp-uuid' do
  impact 1.0
  title 'Ensure uuid & uuid-config binaries are working as expected'
  desc '
  To test the binaries that libossp-uuid provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the binary can be run and where possible we test the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/uuid-config --version
      OSSP uuid 1.6.2 (04-Jul-2008)
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  uuid_exists = command("ls -al #{File.join(target_dir, "uuid")}")
  describe uuid_exists do
    its('stdout') { should match /uuid/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  uuid_works = command("#{File.join(target_dir, "uuid")}")
  describe uuid_works do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  uuid_config_exists = command("ls -al #{File.join(target_dir, "uuid-config")}")
  describe uuid_config_exists do
    its('stdout') { should match /uuid-config/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  uuid_config_works = command("#{File.join(target_dir, "uuid-config")} --version")
  describe uuid_config_works do
    its('stdout') { should match /OSSP uuid #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
