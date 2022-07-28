title 'Tests to confirm wget binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "wget")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-wget-works' do
  impact 1.0
  title 'Ensure wget binary is working as expected'
  desc '
  To test the binary that wget provides, we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/wget --version
      GNU Wget 1.19.5 built on linux-gnu.

      -cares +digest -gpgme +https +ipv6 +iri +large-file -metalink +nls
      +ntlm +opie -psl +ssl/openssl
      ...
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  wget_works = command("#{File.join(bin_dir, "wget")} --version")
  describe wget_works do
    its('stdout') { should match /GNU Wget #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
