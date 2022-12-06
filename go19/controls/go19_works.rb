title 'Tests to confirm go19 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'go19')

control 'core-plans-go19-works' do
  impact 1.0
  title 'Ensure go19 works as expected'
  desc '
  Verify go19 by ensuring that
  (1) its installation directory exists
  (2) its binaries return return expected output.  Note that
      go returns the expected version and runs a script.
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its("exit_status") { should eq 0 }
    its("stdout") { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  {
    "go version" => {
      command_suffix: "",
      command_output_pattern: /go version go#{plan_pkg_version}/
    },
    "gofmt" => {
      command_suffix: "--help",
      command_output_pattern: /usage:\s+gofmt/,
    }
  }.each do |binary_name, value|
    # set default values if each binary_name doesn't define an over-ride
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]} 2>\&1" : "-help 2>\&1"

    # set default @command_under_test only adding a Tempfile if 'script' is defined
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} #{command_suffix}") do
      its("exit_status") { should eq 0 }
      its("stdout") { should match value[:command_output_pattern] }
    end
  end
end
