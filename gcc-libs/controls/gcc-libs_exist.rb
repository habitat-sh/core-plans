title 'Tests to confirm gcc-libs exist as expected'

base_dir = input("base_dir", value: "share")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "gcc-libs")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-gcc-libs' do
  impact 1.0
  title 'Ensure gcc-libs exists'
  desc '
    To test gcc-libs exists we check for the path of the installed packag.
    Then we check that the library exists in the expected location.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  list_files = command("ls -al #{target_dir}")
  describe list_files do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

end
