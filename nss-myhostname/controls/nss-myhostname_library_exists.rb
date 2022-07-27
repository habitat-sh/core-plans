title 'Tests to confirm nss-myhostname library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'nss-myhostname')

control 'core-plans-nss-myhostname-library-exists' do
  impact 1.0
  title 'Ensure nss-myhostname library exists'
  desc '
  Verify nss-myhostname library by ensuring that
  (1) its installation directory exists;
  (2) the library exists;
  (3) its pkgconfig metadata contains the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  library_filename = input('library_filename', value: 'libnss_myhostname.so.2')
  library_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', library_filename)
  describe file(library_full_path) do
    it { should exist }
  end
end
