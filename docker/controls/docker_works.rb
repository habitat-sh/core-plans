title 'Tests to confirm docker works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'docker')

control 'core-plans-docker-works' do
  impact 1.0
  title 'Ensure docker works as expected'
  desc '
  Verify docker by ensuring 
  (1) its installation directory exists and 
  (2) docker returns the expected version
  (3) the rest of the binaries return expected values.
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  full_suite = {
    "containerd" => {},
    "containerd-shim" => {
      exit_pattern: /^[^0]{1}\d*$/, 
      command_output_pattern: /Usage of.*containerd-shim/,
    },
    "docker" => {
      command_suffix: "version",
      command_output_pattern: /Version:\s+(?<version>#{plan_pkg_version})/,
    },
    "docker-init" => {
      exit_pattern: /^[^0]{1}\d*$/, 
    },
    "docker-proxy" => {
      exit_pattern: /^[^0]{1}\d*$/, 
      command_output_pattern: /Usage of.*docker-proxy/,
    },
    "dockerd" => {},
    "runc" => {},
  }

  # Use the following to pull out a subset of the above and test progressively
  subset = full_suite.select { |key, value| key.to_s.match(/^.*$/) }

  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_prefix = value[:command_prefix] || "" 
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]} 2>\&1" : "--help 2>\&1"
    command_output_pattern = value[:command_output_pattern] || /usage:\s*#{binary_name}/i
    exit_pattern = value[:exit_pattern] || /^[0]$/ # use /^[^0]{1}\d*$/ for non-zero exit status

    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_prefix} #{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its("stdout") { should match command_output_pattern }
    end
  end
end
