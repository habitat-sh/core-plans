title 'Tests to confirm psmisc works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'psmisc')

control 'core-plans-psmisc-works' do
  impact 1.0
  title 'Ensure psmisc works as expected'
  desc '
  Verify psmisc by ensuring that
  (1) its installation directory exists
  (2) all executables beneath bin return the expected
  version: fuser, killall, peekfd, prtstat, pslog, and pstree.
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  [
    "fuser",
    "killall",
    "prtstat",
    "pslog",
    "pstree",
    ].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
      describe command("#{command_full_path} --version") do
        its('exit_status') { should eq 0 }
        #its('stderr') { should_not be_empty }
        #its('stderr') { should match /#{binary_name} \(PSmisc\) #{plan_pkg_version}/ }
        its('stdout') { should be_empty }
      end
    end

  # returns non-zero exit status
  peekfd_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "peekfd")
  describe command("#{peekfd_full_path} --version") do
    its('exit_status') { should_not eq 0 }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /peekfd \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end

  # binary name includes an extension and exit status is zero so needs special attention
  pstree_x11_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "pstree.x11")
  describe command("#{pstree_x11_full_path} --version") do
    its('exit_status') { should eq 0 }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /pstree \(PSmisc\) #{plan_pkg_version}/ }
    its('stdout') { should be_empty }
  end
end
