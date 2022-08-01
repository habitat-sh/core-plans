title 'Tests to confirm ldconfig cache only contains this package'

plan_origin = ENV["HAB_ORIGIN"]
plan_name = input("plan_name", value: "glibc")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-check-ld-config' do
  impact 1.0
  title 'Ensure ld-config only contains this pacakge'
  desc '
  To test the ld-config only contains this package, we first have to locate the ldconfig executable.
  We then use this executable to print the cache, so that it can be checked.
  The returned value should contain the libutil.so.1 file that was built with the current package.
    $ PKG_PATH/bin/ldconfig --print-cache | tail -n +1 | awk "{ print $8 }"
    PKG_PATH/lib/libutil.so.1
    ...
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its("stdout") { should_not be_empty }
    #its("stderr") { should be_empty }
    its("exit_status") { should eq 0 }
  end

  ldconfig_binary = File.join(hab_pkg_path.stdout.strip, "/bin/ldconfig")

  ldconfig_check = command("#{ldconfig_binary} --print-cache | head -n -1 | tail -n +1 | awk '{ print $8 }'")
  describe ldconfig_check do
    its("stdout") { should_not be_empty }
    #its("stderr") { should be_empty}
    its("exit_status") { should eq 0}

    for line in ldconfig_check.stdout.split()
      describe command("echo #{line} | cut -d/ -f1-7") do
        its("stdout.strip") { should eq "#{hab_pkg_path.stdout.strip}" }
        #its("stderr") { should be_empty }
        its("exit_status") { should eq 0 }
      end
    end
  end

end
