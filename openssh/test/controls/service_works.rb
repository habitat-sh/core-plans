plan_root = attribute('plan_root', default: '/src/openssh')
pkg_ident = `grep pkg_ident #{plan_root}/results/last_build.env | cut -d \= -f2`.strip
installation_directory = "/hab/pkgs/#{pkg_ident}"
command_test = "#{installation_directory}/sbin/sshd  --help"

control 'ensure openssh binary runs' do
  describe bash(command_test) do
    its('stdout') { should eq '' }
    its('stderr') { should match /usage: sshd/  }
    its('exit_status') { should eq 1 }
  end
end

