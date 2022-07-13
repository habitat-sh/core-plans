title 'Tests to confirm inputproto library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'inputproto')

control 'core-plans-inputproto-library-exists' do
  impact 1.0
  title 'Ensure inputproto library exists'
  desc '
  Verify inputproto library by ensuring that 
  (1) its installation directory exists; 
  (2) verify all header files exist
  (3) its pkgconfig metadata contains the expected version
  '
  
  # (1) its installation directory exists; 
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  # (2) verify all header files exist
  [
    "XIproto.h",
    "XI2.h",
    "XI.h",
    "XI2proto.h",
  ].each do |header_file|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "include", "X11", "extensions", header_file)
      describe file(command_full_path) do
        it { should exist }
        it { should be_readable }
      end
  end

  # (3) its pkgconfig metadata contains the expected version
  plan_pkg_ident = ((plan_installation_directory.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  plan_pkg_version = (plan_pkg_ident.match /^#{plan_origin}\/#{plan_name}\/(?<version>.*)\//)[:version]
  pkgconfig_filename = input('pkgconfig_filename', value: 'inputproto.pc')
  pkgconfig_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', 'pkgconfig', pkgconfig_filename)
  describe command("cat #{pkgconfig_full_path}") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Version: #{plan_pkg_version}/ }
  end
end