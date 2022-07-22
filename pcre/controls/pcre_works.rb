title 'Tests to confirm pcre binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "pcre")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-pcre' do
  impact 1.0
  title 'Ensure pcre binary is working as expected'
  desc '
  To test the binaries that pcre provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/pcregrep --version
      pcregrep version 8.42 2018-03-20
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty}
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  pcretest_exists = command("ls -al #{File.join(target_dir, "pcretest")}")
  describe pcretest_exists do
    its('stdout') { should match /pcretest/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  pcretest_works = command("#{File.join(target_dir, "pcretest")} -C")
  describe pcretest_works do
    its('stdout') { should match /PCRE version #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
 
  pcregrep_exists = command("ls -al #{File.join(target_dir, "pcregrep")}")
  describe pcregrep_exists do
    its('stdout') { should match /pcregrep/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  pcregrep_works = command("#{File.join(target_dir, "pcregrep")} -V")
  describe pcregrep_works do
    its('stdout') { should match /pcregrep version #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  pcre_config_exists = command("ls -al #{File.join(target_dir, "pcre-config")}")
  describe pcre_config_exists do
    its('stdout') { should match /pcre-config/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  pcre_config_works = command("#{File.join(target_dir, "pcre-config")} --version")
  describe pcre_config_works do
    its('stdout') { should match /#{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
