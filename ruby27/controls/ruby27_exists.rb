title 'Tests to confirm ruby27 exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'ruby27')

control 'core-plans-ruby27-exists' do
  impact 1.0
  title 'Ensure ruby27 exists'
  desc '
  Verify ruby27 by ensuring bin/ruby27
  (1) exists and
  (2) is executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "bundle",
    "erb",
    "gem",
    "irb",
    "rake",
    "rdoc",
    "ri",
    "ruby",
    "update_rubygems",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end


