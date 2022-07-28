title 'Tests to confirm bzip2-musl works as expected'

plan_name = input('plan_name', value: 'bzip2-musl')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-bzip2-musl' do
  impact 1.0
  title 'Ensure bzip2-musl works'
  desc '
  We confirm that the bzip2-musl binary is present in the expected location.

    $ ls -al <pkg>/bin/bzip2

  Next, we test for simple execution working:

    $ bzip2 --version
  '
  bzip2_musl_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe bzip2_musl_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  bzip2_musl_pkg_ident = bzip2_musl_pkg_ident.stdout.strip

  describe command("ls -al #{bzip2_musl_pkg_ident}/bin/bzip2") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{bzip2_musl_pkg_ident}/}
    its('exit_status') { should eq 0 }
  end

  describe command("#{bzip2_musl_pkg_ident}/bin/bzip2 --version") do
    its('exit_status') { should eq 0 }
    #its('stderr') { should match /bzip2, a block-sorting file compressor/ }
  end
end
