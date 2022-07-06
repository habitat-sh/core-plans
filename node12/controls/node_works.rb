title 'Tests to confirm node12 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'node12')

control 'core-plans-node-works' do
  impact 1.0
  title 'Ensure node works as expected'
  desc '
  Verify node by ensuring that its
  (1) installation directory exists
  (2) binaries return the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  expected_node_version = plan_installation_directory.stdout.split("/")[5]
  expected_npm_version = input('expected_npm_version', value: '6.14.15')
  {
    "node" => { pattern: "v#{expected_node_version}" },
    "npm" => { pattern: "#{expected_npm_version}" },
    "npx" => { pattern: "#{expected_npm_version}" },
  }.each do |binary_name, version|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match version[:pattern] }
    end
  end
end
