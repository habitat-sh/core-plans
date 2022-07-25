title 'Tests to confirm mg works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'mg')

control 'core-plans-mg-works' do
  impact 1.0
  title 'Ensure mg works as expected'
  desc '
  Verify mg by ensuring that
  (1) its installation directory exists
  (2) it returns a "usage" message when an incorrect option (--version)
  is passed in.  The reason this approach has been used is that correct usage of
  mg does not return testable output: (a) there is no version option
  and (b) exercising mg correctly immediately triggers an emacs/vim-like editor
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  command_relative_path = input('command_relative_path', value: 'bin/mg')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{command_full_path} --version") do
    its('exit_status') { should_not eq 0 }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /usage: mg/ }
    its('stdout') { should be_empty }
  end
end
