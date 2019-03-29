plan_root = attribute('plan_root', default: '/src/haproxy')
pkg_ident = `grep pkg_ident #{plan_root}/results/last_build.env  | cut -d \= -f2`.strip
installation_directory = "/hab/pkgs/#{pkg_ident}"
command_test = "#{installation_directory}/bin/haproxy --help"

control 'ensure haproxy binary command works' do
  describe bash(command_test) do
    its('stdout') { should match /HA-Proxy version/ }
    its('stderr') { should match /Usage : haproxy/  }
    its('exit_status') { should eq 1 }
  end
end
