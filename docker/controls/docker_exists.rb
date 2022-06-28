title 'Tests to confirm docker exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'docker')

control 'core-plans-docker-exists' do
  impact 1.0
  title 'Ensure docker exists'
  desc '
  Verify docker by ensuring bin/docker exists'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "containerd",
    "containerd-shim",
    "ctr",
    "docker",
    "docker-init",
    "docker-proxy",
    "dockerd",
    "runc",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
