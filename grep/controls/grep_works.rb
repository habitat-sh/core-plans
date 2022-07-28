title 'Tests to confirm grep binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "{}")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-grep-works' do
  impact 1.0
  title 'Ensure grep binary is working as expected'
  desc '
  To test the binary that grep provides, we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/grep --version
      grep (GNU grep) 3.3
      Copyright (C) 2018 Free Software Foundation, Inc.
      License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
      This is free software: you are free to change and redistribute it.
      There is NO WARRANTY, to the extent permitted by law.

      Written by Mike Haertel and others; see
      <https://git.sv.gnu.org/cgit/grep.git/tree/AUTHORS>.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")
  #grep_test = input('grep_test', value: " Sleeping /hab/svc/grep/hooks/run")

  grep_version = command("#{File.join(bin_dir, "grep")} --version")
  describe grep_version do
    its('stdout') { should match /grep \(GNU grep\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  #grep_works = command("#{File.join(bin_dir, "grep")} #{grep_test}")
  #describe grep_works do
  #  its('stdout') { should match /Sleeping/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

  #fgrep_version = command("#{File.join(bin_dir, "fgrep")} --version")
  #describe fgrep_version do
  #  its('stdout') { should match /grep \(GNU grep\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

  #fgrep_works = command("#{File.join(bin_dir, "fgrep")} #{grep_test}")
  #describe fgrep_works do
  #  its('stdout') { should match /Sleeping/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

  #egrep_version = command("#{File.join(bin_dir, "egrep")} --version")
  #describe egrep_version do
  #  its('stdout') { should match /grep \(GNU grep\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

  #egrep_works = command("#{File.join(bin_dir, "egrep")} #{grep_test}")
  #describe egrep_works do
  #  its('stdout') { should match /Sleeping/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

end
