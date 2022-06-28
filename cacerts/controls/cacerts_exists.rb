title 'Tests to confirm cacerts exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'cacerts')
 
control 'core-plans-cacerts-exists' do
  impact 1.0
  title 'Ensure cacerts exists'
  desc '
  Verify cert.pem by ensuring (1) the file exists and (2) that
  it contains expected text
  '
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  certificate_relative_path = input('certificate_relative_path', value: '/ssl/cert.pem')
  certificate_full_path = plan_installation_directory.stdout.strip + "#{certificate_relative_path}"
  describe file(certificate_full_path) do
    it { should exist }
  end

  cacerts_file_includes = command("grep \"Certificate data from Mozilla\" #{certificate_full_path}")
  describe cacerts_file_includes do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
