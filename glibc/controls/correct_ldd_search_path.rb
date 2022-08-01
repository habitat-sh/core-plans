title 'Tests to confirm ldd has the correct search path'

plan_origin = ENV["HAB_ORIGIN"]
plan_name = input("plan_name", value: "glibc")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-check-ldd-search-path' do
  impact 1.0
  title 'Ensure correct ldd search path'
  desc '
  To test the correct ldd search path has been set, we must first locate the ldd binary and the path to the ld-linux.so.2 file in the lib directory.
  We then search through the ldd binary for the RTLDLIST.
  The first returned value should equal the /lib/ld-linux.so.2 value
    $ grep "^RTLDLIST=" "$PKG_PATH/bin/ldd" | cut -d \'"\' -f2 | cut -d \' \' -f1
    $PKG_PATH/lib/ld-linux.so.2
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its("stdout") { should_not be_empty }
    #its("stderr") { should be_empty}
    its("exit_status") { should eq 0 }
  end

  ldd_binary = File.join(hab_pkg_path.stdout.strip, "/bin/ldd")
  expected_file = File.join(hab_pkg_path.stdout.strip, "/lib/ld-linux.so.2")

  ldd_search_path_check = command("grep \"^RTLDLIST=\" #{ldd_binary} | cut -d '\"' -f2 | cut -d ' ' -f1")
  describe ldd_search_path_check do
    its("stdout.strip") { should eq "#{expected_file}" }
    #its("stderr") { should be_empty }
    its("exit_status") { should eq 0 }
  end

end
