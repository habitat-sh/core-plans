title 'Tests to confirm vim works as expected'

plan_name = input('plan_name', value: 'vim')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-vim' do
  impact 1.0
  title 'Ensure vim works'
  desc '
  For vim we check that the --version and --help commands work and are correct e.g.

    $ vim --version
    VIM - Vi IMproved 8.1 (2018 May 18, compiled Dec 13 2019 14:45:40)
    Included patches: 1-503, 505-680, 682-1312
    ...

    $ vim --help
    VIM - Vi IMproved 8.1 (2018 May 18, compiled Dec 13 2019 14:45:40)

    Usage: vim [arguments] [file ..]       edit specified file(s)
       or: vim [arguments] -               read text from stdin
    ...
  '
  vim_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe vim_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  vim_pkg_ident = vim_pkg_ident.stdout.strip

  describe command("#{vim_pkg_ident}/bin/vim --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Compiled by Habitat, vim release #{vim_pkg_ident.split('/')[5]}/ }
    #its('stderr') { should be_empty }
  end

  describe command("#{vim_pkg_ident}/bin/vim --help") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /VIM - Vi IMproved/ }
    #its('stderr') { should be_empty }
  end
end
