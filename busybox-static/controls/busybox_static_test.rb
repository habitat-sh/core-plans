title 'Tests to confirm busybox-static works as expected'

plan_name = input('plan_name', value: 'busybox-static')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-busybox-static' do
  impact 1.0
  title 'Ensure busybox-static works'
  desc '
  Many binaries ship with busybox-static. Firstly we check that busybox is statically linked:

    $ file /hab/pkgs/core/busybox-static/1.31.0/20200306011713/bin/busybox
    busybox: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, stripped

  We also call it directly to ensure it is working:

    $ busybox
    BusyBox v1.31.0 (2020-03-06 01:18:21 UTC) multi-call binary.
    BusyBox is copyrighted by many authors between 1998-2015.
    Licensed under GPLv2. See source distribution for detailed
    copyright notices.

    Usage: busybox [function [arguments]...]
    ...

  Finally we confirm that the critical commands used in the studio are present.  Here, we are largely testing
  that the plan is correct and the plan-build behaved correctly.
  '
  busybox_pkg = command("hab pkg path #{plan_ident}")
  describe busybox_pkg do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  busybox_pkg = busybox_pkg.stdout.strip

  file_pkg = command("hab pkg path core/file")
  describe file_pkg do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  file_pkg = file_pkg.stdout.strip

  describe command("#{file_pkg}/bin/file #{busybox_pkg}/bin/busybox") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /statically linked/ }
    its('stdout') { should match /#{busybox_pkg}/ }
  end

  describe command("#{busybox_pkg}/bin/busybox") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /BusyBox v#{busybox_pkg.split('/')[5]}/ }
  end

  commands_to_test = %w(awk basename bash cat chmod chown chroot cut cp dirname env grep id install
                        ln mkdir mount pwd readlink rm sed sh stat tr umount)

  commands_to_test.each do |busybox_command|
    describe command("ls -al #{File.join(busybox_pkg, 'bin', busybox_command)}") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{busybox_command} -> busybox/ }
    end
  end
end
