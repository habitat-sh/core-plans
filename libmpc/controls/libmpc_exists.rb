title 'Tests to confirm libmpc libraries exist'

plan_dirs = input("plan_dirs")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libmpc")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libmpc' do
  impact 1.0
  title 'Ensure libmpc libraries exist as expected'
  desc '
  To test libmpc libraries exist we check for the path of the installed package.
  Then we check that the library exists in the expected location.
  $ ls -al $PKG_PATH/share/
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
      its('stdout') { should_not be_empty }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end

end
