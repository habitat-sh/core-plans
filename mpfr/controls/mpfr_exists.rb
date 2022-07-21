title 'Tests to confirm mpfr libraries exist'

plan_dirs = input("plan_dirs")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "mpfr")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libsodium' do
  impact 1.0
  title 'Ensure mpfr libraries exist as expected'
  desc '
  To test that the libraries that mpfr exports are in the correct file path, we first find the file path for the package.
  Using this file path we then check for the existance of the directories at the expected location.
    $ ls -al $PKG_PATH/include
      . .. mpfr.h mpf2mpfr.h
  '
  
  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty}
    its('exit_status') { should eq 0 }
  end

  plan_dirs.each do | plan_dir |
    describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, plan_dir)}") do
      its('stdout') { should_not be_empty }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end

end
