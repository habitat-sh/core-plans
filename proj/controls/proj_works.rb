title 'Tests to confirm proj binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "proj")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-proj' do
  impact 1.0
  title 'Ensure proj binary is working as expected'
  desc '
  To test the binaries that proj provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the binary exists using simple test commands.
    $ echo 55.2 12.2 | $PKG_PATH/bin/proj +proj=merc +lat_ts=56.5 +ellps=GRS80
      3399483.80      752085.60
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  proj_exists = command("ls #{File.join(target_dir, "proj")}")
  describe proj_exists do
    its('stdout') { should match /proj/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  # Test from https://proj.org/usage/quickstart.html
  proj_works = command("echo 55.2 12.2 | #{File.join(target_dir, "proj")} +proj=merc +lat_ts=56.5 +ellps=GRS80")
  describe proj_works do
    its('stdout') { should match /3399483\.80\s+752085\.60/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  invproj_exists = command("ls #{File.join(target_dir, "invproj")}")
  describe invproj_exists do
    its('stdout') { should match /proj/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  invproj_works = command("echo 55.2 12.2 | #{File.join(target_dir, "invproj")} +proj=merc +lat_ts=56.5 +ellps=GRS80")
  describe invproj_works do
    its('stdout') { should match /0d0\'3\.227\"E\s+0d0\'0\.718\"N/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  invgeod_exists = command("ls #{File.join(target_dir, "invgeod")}")
  describe invgeod_exists do
    its('stdout') { should match /invgeod/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  invgeod_works = command("echo 55.2 12.2 | #{File.join(target_dir, "invgeod")} +proj=merc +lat_ts=56.5 +ellps=GRS80")
  describe invgeod_works do
    its('stdout') { should match /-165d12\'2\.462\"\s+8d24\'5\.605\"\s+6219624\.899/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  cs2cs_exists = command("ls #{File.join(target_dir, "cs2cs")}")
  describe cs2cs_exists do
    its('stdout') { should match /cs2cs/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  cs2cs_works = command("echo 55.2 12.2 | #{File.join(target_dir, "cs2cs")} +proj=merc +lat_ts=56.5 +ellps=GRS80")
  describe cs2cs_works do
    its('stdout') { should match /0d0\'3\.227\"E\s+0d0\'0\.718\"N 0\.000/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  geod_exists = command("ls #{File.join(target_dir, "geod")}")
  describe geod_exists do
    its('stdout') { should match /geod/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  geod_works = command("echo 55.2 12.2 | #{File.join(target_dir, "geod")} +proj=merc +lat_ts=56.5 +ellps=GRS80")
  describe geod_works do
    its('stdout') { should match /55d12\'N\s+12d12\'E\s+\-180d/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
