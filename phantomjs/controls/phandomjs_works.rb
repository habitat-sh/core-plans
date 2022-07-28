title 'Tests to confirm phantomjs binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "phantomjs")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-phantomjs' do
  impact 1.0
  title 'Ensure phantomjs binary is working as expected'
  desc '
  To test the phantomjs binary that core/phantomjs provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/phantomjs --version
      2.1.1
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  phantomjs_exists = command("ls -al #{File.join(target_dir, "phantomjs")}")
  describe phantomjs_exists do
    its('stdout') { should match /phantomjs/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  phantomjs_works = command("#{File.join(target_dir, "phantomjs")} -v")
  describe phantomjs_works do
    its('stdout') { should match /#{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
