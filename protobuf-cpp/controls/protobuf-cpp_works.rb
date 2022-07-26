title 'Tests to confirm protobuf-cpp binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "protobuf-cpp")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-protobuf-cpp' do
  impact 1.0
  title 'Ensure protobuf-cpp binary is working as expected'
  desc '
  To test the protoc binary that protobuf-cpp provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/protoc --version
      libprotoc 3.9.2
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  protoc_exists = command("ls -al #{File.join(target_dir, "protoc")}")
  describe protoc_exists do
    its('stdout') { should match /protoc/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  protoc_works = command("#{File.join(target_dir, "protoc")} --version")
  describe protoc_works do
    its('stdout') { should match /libprotoc #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
