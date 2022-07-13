title 'Tests to confirm iptables exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'iptables')

control 'core-plans-iptables-exists' do
  impact 1.0
  title 'Ensure iptables exists'
  desc '
  Verify iptables by ensuring its binaries
  (1) exist and
  (2) are executable
  ' 

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  {
    "ip6tables" => {},
    "ip6tables-legacy" => {},
    "ip6tables-legacy-restore" => {},
    "ip6tables-legacy-save" => {},
    "ip6tables-restore" => {},
    "ip6tables-save" => {},
    "iptables" => {},
    "iptables-legacy" => {},
    "iptables-legacy-restore" => {},
    "iptables-legacy-save" => {},
    "iptables-restore" => {},
    "iptables-save" => {},
    "iptables-xml" => {
      binary_directory: "bin",
    },
    "xtables-legacy-multi" => {},
  }.each do |binary_name, value|
      binary_directory = value[:binary_directory] || "sbin"
      command_full_path = File.join(plan_installation_directory.stdout.strip, binary_directory, binary_name)
      describe file(command_full_path) do
        it { should exist }
        it { should be_executable }
      end
  end
end
