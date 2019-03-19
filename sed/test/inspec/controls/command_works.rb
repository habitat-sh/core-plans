pkg_ident = `grep pkg_ident results/last_build.env | cut -d \= -f2`.strip
command_path = "/hab/pkgs/#{pkg_ident}/bin/sed"
command_test = "#{command_path} --help"

describe bash(command_test) do
  its('stdout') { should match /Usage: #{command_path} \[OPTION\]/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
