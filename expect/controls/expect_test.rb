title 'Tests to confirm expect works as expected'

plan_name = input('plan_name', value: 'expect')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-expect' do
  impact 1.0
  title 'Ensure expect works'
  desc '
  To test expect is present we check for the executable being present in the expected location.

  We also run the following to ensure expect is functional:
    $ expect -v
    expect version 5.45
  '
  expect_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe expect_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  expect_pkg_ident = expect_pkg_ident.stdout.strip

  describe command("ls -al #{expect_pkg_ident}/bin/expect") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{expect_pkg_ident}/}
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{expect_pkg_ident}/bin/expect -v") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /expect\s+version\s+#{expect_pkg_ident.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
