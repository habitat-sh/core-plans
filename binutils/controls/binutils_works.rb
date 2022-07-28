title 'Tests to confirm binutils works as expected'

plan_name = input('plan_name', value: 'binutils')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-binutils' do
  impact 1.0
  title 'Ensure ld.bfd sets -rpath and -dynamic-linker'
  desc '
  There are two main tests to perform for binutils.  The first is to ensure splitting is performed correctly
  for rpath by setting LD_RUN_PATH and checking the output.

  The debug output looks like
    -rpath
    /path/to
   for every entry in LD_RUN_PATH.

  We also need to ensure that the -dynamic-linker is set to the glibc ld-linux-x86_64.so.2 that this
  package was set with. To do that, we pull out the fully qualified ident for glibc from the DEPS.
  '
  binutils_pkg_ident = command("hab pkg path #{plan_ident}")
  describe binutils_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  binutils_pkg_ident = binutils_pkg_ident.stdout.strip

  glibc_dependency = command("grep \"core/glibc/\" #{binutils_pkg_ident}/DEPS")
  describe glibc_dependency do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  glibc_dependency = glibc_dependency.stdout.strip

  describe command("export DEBUG=true; export LD_RUN_PATH=\"/foo/bar:/baz/lib\"; #{binutils_pkg_ident}/bin/ld.bfd") do
    its('exit_status') { should eq 1 }
    its('stdout') { should be_empty }
    its('stderr') { should match /-rpath\s+\/foo\/bar\s+-rpath\s+\/baz\/lib/ }
    its('stderr') { should_not be_empty }
  end

  describe command("export DEBUG=true; #{binutils_pkg_ident}/bin/ld.bfd") do
    its('exit_status') { should eq 1 }
    its('stdout') { should be_empty }
    its('stderr') { should match /-dynamic-linker\s*\W*\/hab\/pkgs\/#{glibc_dependency}/ }
    its('stderr') { should_not be_empty }
  end
end
