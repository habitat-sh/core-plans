title 'Tests to confirm node12 exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'node12')

control 'core-plans-node-exists' do
  impact 1.0
  title 'Ensure node exists'
  desc '
  Verify node by ensuring binaries 
  (1) exist and
  (2) are executable'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "node",
    "npm",
    "npx",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
