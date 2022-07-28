title 'Tests to confirm diffutils works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'diffutils')

control 'core-plans-diffutils-works' do
  impact 1.0
  title 'Ensure diffutils works as expected'
  desc '
  Verify diffutils by ensuring
  (1) its installation directory exists and
  (2) that it returns the expected version.
  (3) should detect equal contents and also different content.  Note
  since the diff <(..) <(..) works in bash, not in sh, and command(..)
  uses sh, then explicit use of bash(..) not command(..) was used to
  do the verification
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/diff')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{command_full_path} --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /diff \(GNU diffutils\) #{plan_pkg_version}/ }
  end

  describe bash("#{command_full_path} <(echo 'alpha' ) <(echo 'alpha')") do
    its('exit_status') { should eq 0 }
    its('stdout') { should be_empty }
  end

  expected = <<~EOF
    1c1
    < bob
    ---
    > harry
  EOF
  describe bash("#{command_full_path} <(echo 'bob') <(echo 'harry')") do
    its('exit_status') { should_not eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{expected}/ }
  end
end
