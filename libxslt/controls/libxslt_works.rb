title 'Tests to confirm libxslt works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'libxslt')

control 'core-plans-libxslt-works' do
  impact 1.0
  title 'Ensure libxslt works as expected'
  desc '
  Verify libxslt by ensuring that
  (1) its installation directory exists 
  (2) its binaries return the expected output, i.e., version and help usage
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  {
    "xslt-config" => {
      command_suffix: "--version 2>&1",
      command_output_pattern: /#{plan_pkg_version}/,
      exit_pattern: /^0$/,
    },
    "xsltproc" => {
      command_suffix: "2>&1",
      command_output_pattern: /Usage:\s+#{plan_installation_directory.stdout.strip}\/bin\/xsltproc/,
      exit_pattern: /^[^0]{1}\d*$/,
    },
  }.each do |binary_name, value|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} #{value[:command_suffix]}") do
      its('exit_status') { should cmp value[:exit_pattern] }
      its('stdout') { should_not be_empty }
      its('stdout') { should match value[:command_output_pattern] }
    end
  end
end