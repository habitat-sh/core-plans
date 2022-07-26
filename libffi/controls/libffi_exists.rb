title 'Tests to confirm libffi libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libffi")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libffi' do
  impact 1.0
  title 'Ensure libffi libraries exist as expected'
  desc '
  To test libffi libraries exist we check for the path of the installed package.
  Then we check that the library exists in the expected location.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end

end
