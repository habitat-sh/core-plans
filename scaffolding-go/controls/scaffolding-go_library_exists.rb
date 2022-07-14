title 'Tests to confirm scaffolding-go library exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'scaffolding-go')

control 'core-plans-scaffolding-go-library-exists' do
  impact 1.0
  title 'Ensure scaffolding-go library exists'
  desc '
  Verify scaffolding-go library by ensuring that
  (1) its installation directory exists;
  (2) its library file (bash scripts) exist
  NOTE: nothing more is done here than verify that the library files exist.
  To verify the scaffolding works, further habitat building is required.
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "go_module.sh",
    "scaffolding.sh",
    "gopath_mode.sh",
  ].each do |library_filename|
    library_full_path = File.join(plan_installation_directory.stdout.strip, 'lib', library_filename)
    describe file(library_full_path) do
      it { should exist }
    end
  end
end
