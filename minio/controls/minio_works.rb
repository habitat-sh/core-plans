title 'Tests to confirm minio works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'minio')


control 'core-plans-minio-works' do
  impact 1.0
  title 'Ensure minio works as expected'
  desc '
  Verify minio by ensuring that
  (1) its installation directory exists 
  (2) it returns the expected version.  Since some platforms return slightly
  different formats of minio version, some with colons like "2019-07-31T18:57:56Z" 
  others without like "2019-07-31T18:57:56Z", then only the date portion is being 
  used for a successful match.
  '
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stderr') { should be_empty }
  end
  
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "minio")
  describe command("#{command_full_path} --help") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{plan_pkg_version.split("T")[0]}/ }
    its('stderr') { should be_empty }
  end
end