title 'Tests to confirm libarchive binaries work as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "m4")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-m4' do
  impact 1.0
  title 'Ensure m4 binaries are working as expected'
  desc '
  To test the binary that m4 provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/m4 --version
      m4 (GNU M4) 1.4.18
      Copyright (C) 2016 Free Software Foundation, Inc.
      License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
      This is free software: you are free to change and redistribute it.
      There is NO WARRANTY, to the extent permitted by law.

      Written by Rene\' Seindal.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  m4_exists = command("ls -al #{File.join(target_dir, "m4")}")
  describe m4_exists do
    its('stdout') { should match /m4/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  m4_works = command("#{File.join(target_dir, "m4")} --version")
  describe m4_works do
    its('stdout') { should match /m4 \(GNU M4\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
