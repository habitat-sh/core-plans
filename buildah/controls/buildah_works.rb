title 'Tests to confirm buildah works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'buildah')

control 'core-plans-buildah-works' do
  impact 1.0
  title 'Ensure buildah works as expected'
  desc '
  Verify buildah by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "buildah")
  describe command("#{command_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /buildah version #{plan_pkg_version}/ }
  end
end
