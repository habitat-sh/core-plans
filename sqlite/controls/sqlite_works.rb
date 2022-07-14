title 'Tests to confirm sqlite binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "sqlite")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-sqlite' do
  impact 1.0
  title 'Ensure sqlite binary is working as expected'
  desc '
  To test the sqlite3 binary that core/sqlite provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/sqlite3 --version
      3.31.1 2020-01-27 19:55:54 3bfa9cc97da10598521b342961df8f5f68c7388fa117345eeb516eaa837bb4d6
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty}
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  sqlite_exists = command("ls -al #{File.join(target_dir, "sqlite3")}")
  describe sqlite_exists do
    its('stdout') { should match /sqlite3/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  sqlite_works = command("#{File.join(target_dir, "sqlite3")} --version")
  describe sqlite_works do
    its('stdout') { should match /#{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
