title 'Tests to confirm libassuan library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'libassuan')

control 'core-plans-libassuan-library-exists' do
  impact 1.0
  title 'Ensure libassuan library exists'
  desc '
  Verify libassuan library by ensuring that
  (1) its installation directory exists;
  (2) the library exists;
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  library_filename = input('library_filename', value: 'libassuan.so')
  library_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', library_filename)
  describe file(library_full_path) do
    it { should exist }
  end
end
