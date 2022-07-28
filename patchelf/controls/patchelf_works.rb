title 'Tests to confirm patchelf binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "patchelf")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-patchelf' do
  impact 1.0
  title 'Ensure patchelf binary is working as expected'
  desc '
  To test the patchelf binary that core/patchelf  provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/patchelf --version
      patchelf 0.10
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty}
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  patchelf_exists = command("ls -al #{File.join(target_dir, "patchelf")}")
  describe patchelf_exists do
    its('stdout') { should match /patchelf/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  patchelf_works = command("#{File.join(target_dir, "patchelf")} --version")
  describe patchelf_works do
    its('stdout') { should match /patchelf #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
