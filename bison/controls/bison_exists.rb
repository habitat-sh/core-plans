title 'Tests to confirm bison exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'bison')

control 'core-plans-bison-exists' do
  impact 1.0
  title 'Ensure bison exists'
  desc '
  Verify bison by ensuring bin/bison and bin/yacc exists'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  bison_full_path = File.join(plan_installation_directory.stdout.strip, "bin/bison")
  describe file(bison_full_path) do
    it { should exist }
    it { should be_executable }
  end

  yacc_full_path = File.join(plan_installation_directory.stdout.strip, "bin/yacc")
  describe file(yacc_full_path) do
    it { should exist }
    it { should be_executable }
  end
end
