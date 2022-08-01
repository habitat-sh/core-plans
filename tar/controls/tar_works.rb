title 'Tests to confirm tar binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "tar")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-tar-works' do
  impact 1.0
  title 'Ensure tar binary is working as expected'
  desc '
  To test the binary that tar provides, we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/tar --version
      tar (GNU tar) 1.32
      Copyright (C) 2019 Free Software Foundation, Inc.
      License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
      This is free software: you are free to change and redistribute it.
      There is NO WARRANTY, to the extent permitted by law.

      Written by John Gilmore and Jay Fenlason.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  tar_version = command("#{File.join(bin_dir, "tar")} --version")
  describe tar_version do
    its('stdout') { should match /tar \(GNU tar\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  # Tar stderr returns "Removing leading `/' from member names"
  #tar_works = command("#{File.join(bin_dir, "tar")} -cvf run.tar /hab/svc/tar/hooks/run")
  #describe tar_works do
  #  its('stdout') { should match /run/ }
  #  its('exit_status') { should eq 0 }
  #  describe file ("run.tar") do
  #   it { should exist }
  #  end
  #end

end
