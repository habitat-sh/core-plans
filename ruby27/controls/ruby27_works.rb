title 'Tests to confirm ruby27 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'ruby27')

control 'core-plans-ruby27-works' do
  impact 1.0
  title 'Ensure ruby27 works as expected'
  desc '
  Verify ruby27 by ensuring that
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
    "bundle" => {
      # Update the command output match for v2.7.3
      command_output_pattern: /bundle\(1\)/i,
    },
    "erb" => {
      command_suffix: "--help 2>&1",
      command_output_pattern: /erb\s+\[switches\]/,
      exit_pattern: /^[^0]/,
    },
    "gem" => {
      command_suffix: "env",
      command_output_pattern: /RUBY\s+VERSION:\s+#{plan_pkg_version}/,
    },
    "irb" => {},
    # uncomment after fixing issue https://github.com/chef-base-plans/ruby/issues/1
    # "rake" => {
    #   command_output_pattern: /rake \[-f rakefile\]/,
    # },
    "rdoc" => {},
    "ri" => {},
    "ruby" => {
      command_suffix: "--version",
      command_output_pattern: /ruby\s+#{plan_pkg_version}/,
    },
    # uncomment after fixing issue https://github.com/chef-base-plans/ruby/issues/1
    # "update_rubygems" => {
    #   command_output_pattern: /rubygems_update \[options\]/,
    # },
  }
  
  # Use the following to pull out a subset of the above and test progressiveluy
  subset = full_suite.select { |key, value| key.to_s.match(/^.*$/) }
  
  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]}" : "--help"
    command_output_pattern = value[:command_output_pattern] || /usage:(\s+|.*)#{binary_name}/i
    exit_pattern = value[:exit_pattern] || /^[0]$/ # use /^[^0]{1}\d*$/ for non-zero exit status

    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe bash("#{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its('stdout') { should match command_output_pattern }
    end
  end
end