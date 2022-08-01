title 'Tests to confirm libaio library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'libaio')

control 'core-plans-libaio-library-exists' do
  impact 1.0
  title 'Ensure libaio library exists'
  desc '
  Verify libaio library by ensuring that
  (1) its installation directory exists;
  (2) the library exists;
  Note: no pkgconfig metadata present so no way to verify the version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  library_filename = input('library_filename', value: 'libaio.so')
  library_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', library_filename)
  describe file(library_full_path) do
    it { should exist }
  end
end
