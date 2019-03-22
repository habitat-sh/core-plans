pkg_ident = `grep pkg_ident results/last_build.env | cut -d \= -f2`.strip
executable_path = "/hab/pkgs/#{pkg_ident}/bin/sed"

control 'The sed exe exists in the last built package' do
  describe file(executable_path) do
    it { should exist }
  end
end
