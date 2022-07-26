title 'Tests to confirm postgresql exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'postgresql11')

control 'core-plans-postgresql11-exists' do
  impact 1.0
  title 'Ensure postgresql11 exists'
  desc '
  Verify postgresql by ensuring bin/postgres
  (1) exists and
  (2) is executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('stdout') { should_not be_empty }
    # its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  command_full_path = File.join(plan_installation_directory.stdout.strip, 'bin', 'postgres')
  describe file(command_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
