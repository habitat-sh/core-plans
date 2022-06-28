title 'Tests to confirm git binaries works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "git")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-git-works' do
  impact 1.0
  title 'Ensure git binaries are working as expected'
  desc '
  To test the binaries that git provides, we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/git --version
      git version 2.26.2
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  git_works = command("#{File.join(bin_dir, "git")} --version")
  describe git_works do
    its('stdout') { should match /git version #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
