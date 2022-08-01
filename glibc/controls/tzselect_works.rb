title 'Tests to ensure that tzselect works and tzdata is available'

plan_origin = ENV["HAB_ORIGIN"]
plan_name = input("plan_name", value: "glibc")
plan_ident = "#{plan_origin}/#{plan_name}"
tzselect = input("tzselect", value: "/bin/tzselect")

control 'core-plans-check-tzselect-works' do
  impact 1.0
  title 'Ensure tzselect works'
  desc '
  To test that tzselect works, and by extension that tzdata has been installed correctly, we must first locate the tzselect binary.
  We then create an example input file for the tzselect interactive selection.
  We then use this file as an input to tzselect, checking that the selection process works.
  The returned value should equal the expected tzdata for America/Anchorage
    $
    $PKG_PATH/share/locale
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its("stdout") { should_not be_empty }
    #its("stderr") { should be_empty}
    its("exit_status") { should eq 0 }
  end

  tzselect_binary = File.join(hab_pkg_path.stdout.strip, "/bin/tzselect")

  describe bash("echo '2\n49\n22\n1' >> /tmp/tz-test.txt") do
    its('stdout') { should be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0}
  end

  describe bash("#{tzselect_binary} < /tmp/tz-test.txt 2>&1 | tail -n1 ") do
    its('stdout.strip') { should eq "#? America/Anchorage" }
    #its('stderr') { should be_empty}
    its('exit_status') { should eq 0 }
  end

end
