title 'Tests to confirm psmisc exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'psmisc')

control 'core-plans-psmisc-exists' do
  impact 1.0
  title 'Ensure psmisc exists'
  desc '
  Verify psmisc by ensuring all executables beneath bin exist: fuser,
  killall, peekfd, prtstat, pslog, and pstree.'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  [
    "fuser",
    "killall",
    "peekfd",
    "prtstat",
    "pslog",
    "pstree",
    "pstree.x11",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
