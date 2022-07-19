title 'Tests to confirm file binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "file")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-file' do
  impact 1.0
  title 'Ensure file binary is working as expected'
  desc '
  To test the binary that file provides, we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/file --version
      file-5.37
      magic file from /hab/pkgs/core/file/5.37/20200305174635/share/misc/magic
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  file_works = command("#{File.join(bin_dir, "file")} --version")
  describe file_works do
    its('stdout') { should match /file-#{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  #file_test = input('file_test', value: '/hab/svc/file/hooks/run')

  #file_works = command("#{File.join(bin_dir, "file")} #{file_test}")
  #describe file_works do
  #  its('stdout') { should match /Bourne/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

end
