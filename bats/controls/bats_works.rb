title 'Tests to confirm bats works as expected'

plan_name = input('plan_name', value: 'bats')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-bats' do
  impact 1.0
  title 'Ensure bats works'
  desc '
  There are two main tests to perform for bats.  We check that the version is correct e.g.

    $ bats --version
    Bats 0.4.0

  We also check that bats help message works e.g.

    $ bats --help
    Bats 0.4.0
    ...
  '
  bats_pkg_ident = command("hab pkg path #{plan_ident}")
  describe bats_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  bats_pkg_ident = bats_pkg_ident.stdout.strip

  describe command("#{bats_pkg_ident}/bin/bats --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Bats\s+#{bats_pkg_ident.split('/')[5]}/ }
  end

  describe command("#{bats_pkg_ident}/bin/bats --help") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Bats\s+#{bats_pkg_ident.split('/')[5]}/ }
  end
end
