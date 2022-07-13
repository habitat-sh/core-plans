title 'Tests to confirm zip works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'zip')

control 'core-plans-zip-works' do
  impact 1.0
  title 'Ensure zip works as expected'
  desc '
  Verify zip by ensuring that
  (1) its installation directory exists 
  (2) its binaries return expected version
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  {
    "zip" => {
      command_output_pattern: /Zip #{plan_pkg_version}/,
    },
    "zipcloak" => {
      command_output_pattern: /ZipCloak #{plan_pkg_version}/,
    },
    "zipnote" => {
      command_output_pattern: /ZipNote #{plan_pkg_version}/,
    },
    "zipsplit" => {
      command_output_pattern: /ZipSplit #{plan_pkg_version}/,
    },
  }.each do |binary_name, value|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} -h") do
      its('exit_status') { should eq 0 }
      its('stdout') { should match value[:command_output_pattern] }
    end
  end
end