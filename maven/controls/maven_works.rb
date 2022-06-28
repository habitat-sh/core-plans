title 'Tests to confirm maven works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'maven')

control 'core-plans-maven-works' do
  impact 1.0
  title 'Ensure maven works as expected'
  desc '
  Verify maven by ensuring that
  (1) its installation directory exists 
  (2) its binaries return the expected output
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  full_suite = {
    "mvn" => {
      command_prefix: "hab pkg exec #{plan_origin}/#{plan_name} --",
      command_suffix: "--version",
      command_output_pattern: /Apache Maven #{plan_pkg_version}/,
    },
    "mvnDebug" => {
      command_prefix: "timeout 1",
      command_suffix: "--help",
      command_output_pattern: /Preparing to execute Maven in debug mode/,
      exit_pattern: /^[^0]/,
    },
    "mvnyjp" => {
      command_output_pattern: /Please set YJPLIB variable/,
      exit_pattern: /^[^0]/,
    },
  }
  
  # Use the following to pull out a subset of the above and test progressiveluy
  subset = full_suite.select { |key, value| key.to_s.match(/^[a-z].*$/) }
  
  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_prefix = value[:command_prefix] || "" # "echo '{\"key\":\"value\"}' | "
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]} 2>&1" : "-help 2>&1"
    command_output_pattern = value[:command_output_pattern] || /usage:(\s+|.*)#{binary_name}/i
    exit_pattern = value[:exit_pattern] || /^[0]$/ # use /^[^0]{1}\d*$/ for non-zero exit status

    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_prefix} #{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its('stdout') { should match command_output_pattern }
    end
  end
end