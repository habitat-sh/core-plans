title 'Tests to confirm xcb-proto library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'xcb-proto')

control 'core-plans-xcb-proto-library-exists' do
  impact 1.0
  title 'Ensure xcb-proto library exists'
  desc '
  Verify xcb-proto library by ensuring that
  (1) its installation directory exists;
  (2) the site-package for xcbgen exists
  (3) its pkgconfig metadata contains the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  library_filename = input('library_filename', value: 'xcb-proto.so')
  library_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', 'python2.7', 'site-packages', 'xcbgen', '__init__.py')
  describe file(library_full_path) do
    it { should exist }
  end

  plan_pkg_ident = ((plan_installation_directory.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  plan_pkg_version = (plan_pkg_ident.match /^#{plan_origin}\/#{plan_name}\/(?<version>.*)\//)[:version]
  pkgconfig_filename = input('pkgconfig_filename', value: 'xcb-proto.pc')
  pkgconfig_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', 'pkgconfig', pkgconfig_filename)
  describe command("cat #{pkgconfig_full_path}") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Version:\s+#{plan_pkg_version}/ }
    # TODO: REMOVE ME # its('stderr') { should be_empty }
  end
end
