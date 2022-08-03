title 'Ensure xlib libraries exist'

plan_name = input("plan_name", value: "zlib")
lib_path = input('base_dir', value: '/lib/libz.so')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-zlib' do
  impact 1.0
  title 'Ensure zlib exists'
  desc '
  To test zlib libraries are installed we first get the path to the package.
  Using that path we can check for the existance of the zlib library directory
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_path = File.join(hab_pkg_path.stdout.strip, lib_path)
  describe command("ls -al #{target_path}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
