title 'Tests to confirm sed binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "sed")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-sed-works' do
  impact 1.0
  title 'Ensure sed binary is working as expected'
  desc '
  To test the binary that sed provides, we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/sed --version
      sed (GNU sed) 4.5
      Copyright (C) 2018 Free Software Foundation, Inc.
      License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
      This is free software: you are free to change and redistribute it.
      There is NO WARRANTY, to the extent permitted by law.

      Written by Jay Fenlason, Tom Lord, Ken Pizzini,
      and Paolo Bonzini.
      GNU sed home page: <https://www.gnu.org/software/sed/>.
      General help using GNU software: <https://www.gnu.org/gethelp/>.
      E-mail bug reports to: <bug-sed@gnu.org>.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  sed_version = command("#{File.join(bin_dir, "sed")} --version")
  describe sed_version do
    its('stdout') { should match /sed \(GNU sed\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  #sed_works = command("#{File.join(bin_dir, "sed")} s/exec/leader/1 /hab/svc/sed/hooks/run")
  #describe sed_works do
  #  its('stdout') { should match /leader/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

end
