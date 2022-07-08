title 'Tests to confirm sqitch works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'sqitch')

control 'core-plans-sqitch-works' do
  impact 1.0
  title 'Ensure sqitch works as expected'
  desc '
  Verify sqitch by ensuring that
  (1) its installation directory exists 
  (2) it returns the expected version
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  full_suite = {
    "config_data" => {
      command_output_pattern: /Usage:\s+.*config_data\s+\[options\]/,
    },
    # strips pid numbers, hex, etc.  See https://docs.oracle.com/cd/E36784_01/html/E36870/dbilogstrip-1.html
    "dbilogstrip" => {
      command_suffix: '<(echo "pid#6254")',
      command_output_pattern: /pidN/,
    },
    "dbiprof" => {
      exit_pattern: /^[^0]/,
    },
    # ignoring dbiproxy until issue fixed.  See https://github.com/chef-base-plans/sqitch/issues/2
    # "dbiproxy" => {},
    "package-stash-conflicts" => {
      command_suffix: "",
      command_output_pattern: /^$/,
    },
    "shell-quote" => {
      command_suffix: "--help 2>&1",
      command_output_pattern: /usage:\s+shell-quote\s+\[switch\]/,
      exit_pattern: /^[^0]/,
    },
    "sqitch" => {
      command_suffix: "--version",
      command_output_pattern: /sqitch\s+\(App::Sqitch\)\s+#{plan_pkg_version}/,
    },
  }
  
  # Use the following to pull out a subset of the above and test progressiveluy
  subset = full_suite.select { |key, value| key.to_s.match(/^.*$/) }
  
  # over-ride the defaults below with (command_suffix:, io:, Etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]}" : "-help"
    command_output_pattern = value[:command_output_pattern] || /#{binary_name}\s+\[options\]\s+\[files\]/i
    exit_pattern = value[:exit_pattern] || /^[0]$/ # use /^[^0]{1}\d*$/ for non-zero exit status

    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe bash("#{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its('stdout') { should match command_output_pattern }
    end
  end
end