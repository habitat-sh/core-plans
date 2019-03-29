plan_root = attribute('plan_root', default: '/src/haproxy')
pkg_ident = `grep pkg_ident #{plan_root}/results/last_build.env | cut -d \= -f2`.strip
installation_directory = "/hab/pkgs/#{pkg_ident}"
command_path = "#{installation_directory}/bin/haproxy"

control 'ensure haproxy binary exists' do
  describe file(command_path) do
    it { should exist }
  end
end
