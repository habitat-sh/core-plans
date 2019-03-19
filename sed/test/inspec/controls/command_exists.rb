pkg_ident = `grep pkg_ident results/last_build.env | cut -d \= -f2`.strip
command_path = "/hab/pkgs/#{pkg_ident}/bin/sed"

describe file(command_path) do
  it { should exist }
end
