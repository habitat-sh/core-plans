title 'Tests to confirm correct abi version'

plan_origin = ENV["HAB_ORIGIN"]
plan_name = input("plan_name", value: "glibc")
plan_ident = "#{plan_origin}/#{plan_name}"
abi_version = input("abi_version", value: "3.2.0")

control 'core-plans-check-abi-version' do
  impact 1.0
  title 'Ensure correct abi version'
  desc '
  To test the correct abi version has been installed we check for the location of the libc.so file.
  We then install core/binutils so that we can use readelf to display information about the libc.so file.
  The returned value should equal the abi_version we set in our input file.
    $ readelf -n "TARGET_FILE" | grep "OS: Linux, ABI:" | awk \'{ print $4 }\'
    3.2.0
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its("stdout") { should_not be_empty }
    #its("stderr") { should be_empty}
    its("exit_status") { should eq 0 }
  end

  glibc_version = command("cut -d/ -f3 #{hab_pkg_path.stdout.strip}/IDENT")
  describe glibc_version do
    its("stdout") { should match /[0-9]+.[0-9]+/ }
    #its("stderr") { should be_empty }
    its("exit_status") { should eq 0 }
  end

	# Starting with glibc 2.34, the shared objects are installed under their
	# ABI sonames directly, without symbolic links.  This increases
	# compatibility with distribution package managers that delete removed
	# files late during the package upgrade or downgrade process
	target_file = File.join(hab_pkg_path.stdout.strip, "lib/libc.so.6")

  get_binutils = command("hab pkg install core/binutils --binlink --force")
  #describe get_binutils do
  #  its("stdout") { should match /Installing core\/binutils/ }
  #  its("stdout") { should match /Binlinked readelf/ }
  #  #its("stderr") { should be_empty}
  #  its("exit_status") { should eq 0 }
  #end

  abi_check = command("readelf -n \"#{target_file}\" | grep \"OS: Linux, ABI:\" | awk '{ print $4 }'")
  describe abi_check do
    its("exit_status") { should eq 0 }
    its("stdout.strip") { should eq abi_version }
  end

end
