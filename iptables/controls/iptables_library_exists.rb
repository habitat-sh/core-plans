title 'Tests to confirm iptables library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'iptables')

control 'core-plans-iptables-library-exists' do
  impact 1.0
  title 'Ensure iptables library exists'
  desc '
  Verify iptables library by ensuring that
  (1) its installation directory exists;
  (2) its libraries exist;
  (3) each pkgconfig metadata contains the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  # (2) its libraries exist;
  [
    "libip4tc.so",
    "libip6tc.so",
    "libipq.so",
    "libxtables.so",
  ]. each do |library_filename|
    library_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', library_filename)
    describe file(library_full_path) do
      it { should exist }
    end
  end

  # (3) their pkgconfig metadata contains the expected version
  plan_pkg_ident = ((plan_installation_directory.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  plan_pkg_version = (plan_pkg_ident.match /^#{plan_origin}\/#{plan_name}\/(?<version>.*)\//)[:version]
  [
    "libip4tc.pc",
    "libip6tc.pc",
    "libipq.pc",
    "libiptc.pc",
    "xtables.pc",
  ]. each do |pkgconfig_filename|
    pkgconfig_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', 'pkgconfig', pkgconfig_filename)
    describe command("cat #{pkgconfig_full_path}") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /Version:\s+#{plan_pkg_version}/ }
    end
  end
end
