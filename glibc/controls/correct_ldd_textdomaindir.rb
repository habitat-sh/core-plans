title 'Tests to ensure correct textdomaindir is set'

plan_origin = ENV["HAB_ORIGIN"]
plan_name = input("plan_name", value: "glibc")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-check-textdomaindir' do
  impact 1.0
  title 'Ensure correct textdomaindir is set'
  desc '
  To test the correct textdomaindir has been set, we must first locate the ldd binary and the path to the locale file in the share directory.
  We then search through the ldd binary for the TEXTDOMAINDIR.
  The returned value should equal the /share/locale file.
    $ grep "TEXTDOMAINDIR" "$PKG_PATH/bin/ldd" | cut -d \'=\' -f2
    $PKG_PATH/share/locale
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its("stdout") { should_not be_empty }
    #its("stderr") { should be_empty}
    its("exit_status") { should eq 0 }
  end

  ldd_binary = File.join(hab_pkg_path.stdout.strip, "/bin/ldd")
  expected_file = File.join(hab_pkg_path.stdout.strip, "/share/locale")

  ldd_textdomaindir_check = command("grep TEXTDOMAINDIR #{ldd_binary} | cut -d '=' -f2")
  describe ldd_textdomaindir_check do
    its("stdout.strip") { should eq "#{expected_file}" }
    #its("stderr") { should be_empty }
    its("exit_status") { should eq 0 }
  end

end
