title 'Tests to confirm that library files exist'

plan_dirs = input("plan_dirs")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "gmp")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-check-library' do
  impact 1.0
  title 'Ensure library files exist'
  desc '
  To test that the library files we expect to exist at the expected location, we first must find the path to the package.
  Using this path we check that each of the paths exist.
    $ ls -al $PKG_PATH/include
      gmp.h
    $ ls -al $PKG_PATH/lib
      libgmp.a libgmp.la libgmp .so libgmp.so.10 libgmp.so.10.3.2
    $ ls -al $PKG_PATH/share
      info/
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  plan_dirs.each do | plan_dir |
    describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, plan_dir)}") do
      #its('stderr') { should eq '' }
      its('stdout') { should_not be_empty }
      its('exit_status') { should eq 0 }
    end
  end

end
