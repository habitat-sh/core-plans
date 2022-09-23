title 'Tests to confirm go17 exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'go17')

control 'core-plans-go17-exists' do
  impact 1.0
  title 'Ensure go17 exists'
  desc '
  Verify go17 by ensuring bin/go
  (1) exists and
  (2) is executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  ["go", "gofmt"].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
      describe file(command_full_path) do
        it { should exist }
        it { should be_executable }
      end
  end
end
