title 'Tests to confirm libpthread-stubs library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'libpthread-stubs')

control 'core-plans-libpthread-stubs-library-exists' do
  impact 1.0
  title 'Ensure libpthread-stubs library exists'
  desc '
  Verify libpthread-stubs library by ensuring that 
  (1) its installation directory exists; 
  (2) its pkgconfig metadata contains the expected version.  Note that this is
      the only file associated with this library.  See https://gitlab.freedesktop.org/xorg/lib/pthread-stubs
      for more information.
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_ident = ((plan_installation_directory.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  plan_pkg_version = (plan_pkg_ident.match /^#{plan_origin}\/#{plan_name}\/(?<version>.*)\//)[:version]
  pkgconfig_filename = input('pkgconfig_filename', value: 'pthread-stubs.pc')
  pkgconfig_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', 'pkgconfig', pkgconfig_filename)
  describe command("cat #{pkgconfig_full_path}") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Version:\s+#{plan_pkg_version}/ }
  end
end