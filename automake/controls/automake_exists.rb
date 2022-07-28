title 'Tests to confirm automake exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'automake')

control 'core-plans-automake-exists' do
  impact 1.0
  title 'Ensure automake exists'
  desc '
  Verify automake by ensuring bin/automake exists'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  automake_full_path = File.join(plan_installation_directory.stdout.strip, "bin/automake")
  describe file(automake_full_path) do
    it { should exist }
    it { should be_executable }
  end

  aclocal_full_path = File.join(plan_installation_directory.stdout.strip, "bin/aclocal")
  describe file(aclocal_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
