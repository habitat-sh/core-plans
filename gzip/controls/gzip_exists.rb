title 'Tests to confirm the gzip binary exists'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "gzip")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-gzip-exists' do
  impact 1.0
  title 'Ensure the gzip binary exists'
  desc '
  To test that the gzip binary exists we must first find the package path.
  Using that path we can check for the binaries existance.
    $ ls -al $PKG_PATH/bin/gzip
      -rwxr-xr-x 1 root root 94104 Mar  6 00:24 /hab/pkgs/core/gzip/1.10/20200306002325/bin/gzip
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  binaries_to_test = %w(gunzip gzip zcat zdiff zfgrep zgrep zmore gzexe uncompress zcmp zegrep zforce zless znew)

  binaries_to_test.each do |binary|
    describe command("ls -al #{File.join(bin_dir, binary)}") do
      its('stdout') { should match /#{binary}/ }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end

end
