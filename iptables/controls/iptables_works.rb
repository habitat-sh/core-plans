title 'Tests to confirm iptables works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'iptables')

control 'core-plans-iptables-works' do
  impact 1.0
  title 'Ensure iptables works as expected'
  desc '
  Verify iptables by ensuring that
  (1) its installation directory exists
  (2) its binaries return expected output either version or help usage
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  full_suite = {
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
      command_suffix: "-h 2>&1",
      command_output_pattern: /usage:\s+iptables-xml/i,
      bin_directory: "bin",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "xtables-legacy-multi" => {
      command_suffix: "iptables --version",
      command_output_pattern: /iptables\s+v#{plan_pkg_version}\s+\(legacy\)/,
    },
  }

  # Use the following to pull out a subset of the above and test progressiveluy
  subset = full_suite.select { |key, value| key.to_s.match(/^.*$/) }

  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]}" : "--version"
    command_output_pattern = value[:command_output_pattern] || /#{binary_name.gsub("-legacy","")}\s+v#{plan_pkg_version}/i
    exit_pattern = value[:exit_pattern] || /^[0]$/ # use /^[^0]{1}\d*$/ for non-zero exit status
    bin_directory = value[:bin_directory] || "sbin"

    # verify
    command_full_path = File.join(plan_installation_directory.stdout.strip, bin_directory, binary_name)
    describe command("#{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its('stdout') { should match command_output_pattern }
    end
  end
end
