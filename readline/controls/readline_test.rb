title 'Tests to confirm readline works as expected'

plan_name = input('plan_name', value: 'readline')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-readline' do
  impact 1.0
  title 'Ensure readline works'
  desc '
  There are two main tests to perform for readline.  We check that the shared library exists in
  the correct location and also that ldd works and shows ncurses is linked.

    $ ls -al /hab/pkgs/core/readline/8.0/20200305232850/lib/libreadline.so
    lrwxrwxrwx 1 root root 16 Mar  5 23:29 /hab/pkgs/core/readline/8.0/20200305232850/lib/libreadline.so -> libreadline.so.8

    $ ldd libreadline.so
    linux-vdso.so.1 (0x00007ffe4c3d0000)
    libncursesw.so.6 => libncursesw.so.6 (0x00007f8169b56000)
    libc.so.6 => libc.so.6 (0x00007f8169993000)
    libtinfow.so.6 => libtinfow.so.6 (0x00007f8169953000)
    ld-linux-x86-64.so.2 (0x00007f8169bf7000)
  '
  readline_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe readline_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  readline_pkg_ident = readline_pkg_ident.stdout.strip

  describe command("ls -al #{readline_pkg_ident}/lib/libreadline.so") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{readline_pkg_ident}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  glibc = command("#{hab_path} pkg path core/glibc")
  describe glibc do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  glibc = glibc.stdout.strip

  describe command("#{glibc}/bin/ldd #{readline_pkg_ident}/lib/libreadline.so") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /ncurses/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
