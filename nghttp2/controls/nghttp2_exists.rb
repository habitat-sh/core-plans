title 'Tests to confirm nghttp2 libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "nghttp2")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-nghttp2' do
  impact 1.0
  title 'Ensure nghttp2 libraries exist as expected'
  desc '
  To test that the libraries that nghttp2 export are in the correct file path, we first find the file path for the package.
  Using this file path we then check for the existance of the directories at the expected location.
    $ ls -al $PKG_PATH/include/
      . .. nghttp2/
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
