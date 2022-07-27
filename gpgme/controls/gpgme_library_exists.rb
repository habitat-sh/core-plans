title 'Tests to confirm gpgme library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'gpgme')

control 'core-plans-gpgme-library-exists' do
  impact 1.0
  title 'Ensure gpgme library exists'
  desc '
  Verify gpgme library by ensuring that
  (1) its installation directory exists;
  (2) the library exists;
  (3) its included binaries return the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  library_filename = input('library_filename', value: 'libgpgme.so')
  library_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', library_filename)
  describe file(library_full_path) do
    it { should exist }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  ["gpgme-tool", "gpgme-config"].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{plan_pkg_version}/ }
    end
  end
end
