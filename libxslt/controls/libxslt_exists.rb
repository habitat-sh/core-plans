title 'Tests to confirm libxslt exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'libxslt')

control 'core-plans-libxslt-exists' do
  impact 1.0
  title 'Ensure libxslt exists'
  desc '
  Verify libxslt by ensuring bin/xslt-config
  (1) exists and
  (2) its binaries are executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "xslt-config",
    "xsltproc",
  ].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
      describe file(command_full_path) do
        it { should exist }
        it { should be_executable }
      end
  end
end
