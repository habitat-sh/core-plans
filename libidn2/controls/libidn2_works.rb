title 'Tests to confirm libidn2 binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libidn2")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libidn2' do
  impact 1.0
  title 'Ensure libidn2 binary is working as expected'
  desc '
  To test the idn2 binary that libidn2 provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/idn2 --version
      idn2 (libidn2) 2.0.4
      Copyright (C) 2017 Simon Josefsson.
      License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
      This is free software: you are free to change and redistribute it.
      There is NO WARRANTY, to the extent permitted by law.

      Written by Simon Josefsson.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  idn2_exists = command("ls #{File.join(target_dir, "idn2")}")
  describe idn2_exists do
    its('stdout') { should match /libidn2/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  idn2_works = command("#{File.join(target_dir, "idn2")} --version")
  describe idn2_works do
    its('stdout') { should match /idn2 \(Libidn2\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
