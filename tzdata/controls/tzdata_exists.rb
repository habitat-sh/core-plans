title 'Tests to verify tzdata exists'

plan_timezones = input("plan_timezones")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "tzdata")
base_dir = input("base_dir", value: "include")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-tzdata' do
  impact 1.0
  title 'Ensure tzdata is installed as expected'
  desc '
  To test that the libraries that tzdata export are in the correct file path, we first find the file path for the package.
  Using this file path we then check for the existance of the timezone data at the expected location.
    $ ls -al $PKG_PATH/sahre/zoneinfo/posix
      . .. Africa America Antarctica Arctic Asia ...
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  plan_timezones.each do | plan_timezone |
    describe command("ls -al #{File.join(target_dir, plan_timezone)}") do
      its('stdout') { should_not be_empty }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end

end
