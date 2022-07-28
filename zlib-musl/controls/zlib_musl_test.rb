title 'Tests to confirm zlib-musl works as expected'

plan_name = input('plan_name', value: 'zlib-musl')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-zlib-musl' do
  impact 1.0
  title 'Ensure zlib-musl works'
  desc '
  We confirm that the zlib-musl library is present in the expected location.

    $ ls -al <pkg>/lib/libz.so
  '
  zlib_musl_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe zlib_musl_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  zlib_musl_pkg_ident = zlib_musl_pkg_ident.stdout.strip

  describe command("ls -al #{zlib_musl_pkg_ident}/lib/libz.so") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{zlib_musl_pkg_ident}/}
    its('exit_status') { should eq 0 }
  end
end
