title 'Tests to confirm check works as expected'

plan_name = input('plan_name', value: 'check')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-check' do
  impact 1.0
  title 'Ensure check works'
  desc '
  We run the following to ensure checkmk is correctly packaged:
    $ ls -al <pkg>/lib/libcheck.so
    $ ls -al <pkg>/bin/checkmk
  '
  check_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe check_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  check_pkg_ident = check_pkg_ident.stdout.strip

  describe command("ls -al #{check_pkg_ident}/lib/libcheck.so") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{check_pkg_ident}/}
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{check_pkg_ident}/bin/checkmk") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{check_pkg_ident}/}
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
