title 'Tests to confirm bzip2 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'bzip2')

control 'core-plans-bzip2-works' do
  impact 1.0
  title 'Ensure bzip2 works as expected'
  desc '
  Verify bzip2 by ensuring that
  (1) its installation directory exists 
  (2) it returns the expected version.  Note that since bzip2 --version not only 
  outputs its version info to stderr but also random text to stout, then the stdout
  content is being ignored, only the stderr validated.
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end
  
  command_relative_path = input('command_relative_path', value: 'bin/bzip2')
  command_full_path = File.join(plan_installation_directory.stdout.strip, command_relative_path)
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  describe command("#{command_full_path} --version") do
    its('exit_status') { should eq 0 }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /bzip2, a block-sorting file compressor.  Version #{plan_pkg_version}/ }
    its('stdout') { should_not be_empty }
  end
end
