title 'Tests to confirm the git binaries exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "git")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-git-exists' do
  impact 1.0
  title 'Ensure the git binaries exists'
  desc '
  To test that the git binaries exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/git
      -rwxr-xr-x 130 root root 3531816 Jun  1 12:12 /hab/pkgs/core/git/2.26.2/20200601121014/bin/git
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  git_exists = command("ls -al #{File.join(bin_dir, "git")}")
  describe git_exists do
    its('stdout') { should match /git/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  git_cvsserver_exists = command("ls -al #{File.join(bin_dir, "git-cvsserver")}")
  describe git_cvsserver_exists do
    its('stdout') { should match /git-cvsserver/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  git_receive_pack_exists = command("ls -al #{File.join(bin_dir, "git-receive-pack")}")
  describe git_receive_pack_exists do
    its('stdout') { should match /git-receive-pack/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  git_shell_exists = command("ls -al #{File.join(bin_dir, "git-shell")}")
  describe git_shell_exists do
    its('stdout') { should match /git-shell/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  git_upload_archive_exists = command("ls -al #{File.join(bin_dir, "git-upload-archive")}")
  describe git_upload_archive_exists do
    its('stdout') { should match /git-upload-archive/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  git_upload_pack_exists = command("ls -al #{File.join(bin_dir, "git-upload-pack")}")
  describe git_upload_pack_exists do
    its('stdout') { should match /git-upload-pack/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  gitk_exists = command("ls -al #{File.join(bin_dir, "gitk")}")
  describe gitk_exists do
    its('stdout') { should match /gitk/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
