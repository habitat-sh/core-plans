title 'Tests to confirm clens works as expected'

plan_name = input('plan_name', value: 'clens')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-clens' do
  impact 1.0
  title 'Ensure clens works'
  desc '
  We confirm that the clens library is present in the expected location.

    $ ls -al <pkg>/lib/libclens.a
  '
  clens_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe clens_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  clens_pkg_ident = clens_pkg_ident.stdout.strip

  describe command("ls -al #{clens_pkg_ident}/lib/libclens.a") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{clens_pkg_ident}/}
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
