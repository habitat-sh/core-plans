path_prefix = os.family == "windows" ? 'c:' : ''
pkg_ident = attribute('pkg_ident', default: '')
installation_directory = "#{path_prefix}/hab/pkgs/#{pkg_ident}"
command_name = os.family == "windows" ? 'git.exe' : 'git'

command_test = "#{installation_directory}/bin/#{command_name} --help"
control 'ensure git binary command works' do
  describe command(command_test) do
  its('stdout') { should match /usage: git/ }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
