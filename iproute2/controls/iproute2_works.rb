title 'Tests to confirm iproute2 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'iproute2')

control 'core-plans-iproute2-works' do
  impact 1.0
  title 'Ensure iproute2 works as expected'
  desc '
  Verify iproute2 by ensuring that
  (1) its installation directory exists
  (2) all binaries return expected output.  NOTE: the version DOES NOT
  correspond to the one obtained from the executables and no clear map was
  discovered.  For example, the current version is 4.16.0 but the version returned
  by the binaries is something like iproute2-ss180402.  The closest info found that
  maps these version was found here https://news.ycombinator.com/item?id=17151777.
  No version checking is therefore done in these tests
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  full_suite = {
    "bridge" => {
      command_prefix: "hab pkg exec #{plan_origin}/#{plan_name}",
      command_suffix: "help",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "ctstat" => {
      command_suffix: "--help",
      command_output_pattern: /ctstat Version/,
    },
    "genl" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "ifcfg" => {
      command_suffix: "",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "ifstat" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "ip" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "lnstat" => {
      command_output_pattern: /lnstat Version/,
    },
    "nstat" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "routef" => {},
    "routel" => {
      command_suffix: "",
      command_output_pattern: /target\s+gateway\s+source\s+proto\s+scope\s+dev\s+tbl/,
    },
    "rtacct" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "rtmon" => {
      command_suffix: "help",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    # replaces backslashes with newlines
    "rtpr" => {
      command_prefix: "echo 'line one\\line two\\line three' | ",
      command_output_pattern: /line one\nline two\nline three/,
    },
    "rtstat" => {
      command_output_pattern: /rtstat Version/,
    },
    "ss" => {},
    "tc" => {},
  }

  # Use the following to pull out a subset of the above and test progressiveluy
  subset = full_suite.select { |key, value| key.to_s.match(/^.*$/) }

  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_prefix = value[:command_prefix] || "" # "echo '{\"key\":\"value\"}' | "
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]} 2>&1" : "-help 2>&1"
    command_output_pattern = value[:command_output_pattern] || /usage:(\s+|.*)#{binary_name}/i
    exit_pattern = value[:exit_pattern] || /^[0]$/ # use /^[^0]{1}\d*$/ for non-zero exit status

    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "sbin", binary_name)
    describe command("#{command_prefix} #{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its('stdout') { should match command_output_pattern }
    end
  end
end
