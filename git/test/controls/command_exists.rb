path_prefix = os.family == "windows" ? 'c:' : ''
pkg_ident = attribute('pkg_ident', default: '')
installation_directory = "#{path_prefix}/hab/pkgs/#{pkg_ident}"
command_name = os.family == "windows" ? 'git.exe' : 'git'

command_path = "#{installation_directory}/bin/#{command_name}"
control 'ensure git binary exists' do
  describe file(command_path) do
    it { should exist }
  end
end
