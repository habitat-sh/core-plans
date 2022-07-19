title 'Tests to confirm libiconv exists and works'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libiconv")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libiconv' do
  impact 1.0
  title 'Ensure libiconv exists and works as expected'
  desc '
  To test that the iconv binary that libiconv creates works as expected we first get the path that it is installed at.
  This path is then used to existance of and the execution of the iconv binary to ensure that it both exists and works as expected with the correct libiconv version installed.
    $ $PKG_PATH/bin/inconv --version
      iconv (GNU libiconv 1.14)
      Copyright (C) 2000-2011 Free Software Foundation, Inc.
      License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
      This is free software: you are free to change and redistribute it.
      There is NO WARRANTY, to the extent permitted by law.
      Written by Bruno Haible.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "bin/iconv")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{File.join(hab_pkg_path.stdout.strip, "bin/iconv")} --version") do
    its('stdout') { should match /iconv \(GNU libiconv #{hab_pkg_path.stdout.strip.split('/')[5]}\)/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
