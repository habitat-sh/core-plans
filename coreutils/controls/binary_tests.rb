title 'Tests to confirm that coreutil binaries are working as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "{}")
plan_ident = "#{plan_origin}/#{plan_name}"
allow_list = input("allow_list")
block_list = input("block_list")

control 'core-plans-coreutil-binaries-work' do
  impact 1.0
  title 'Ensure coreutil binaries are working as expected'
  desc '
  To test the binaries that coreutils provides, we first check for the installation directory.
  Using this directory we then check that the file exists, isnt empty and is executable.
  Then we run checks to determine if a version/help/other simple commands can be run.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  # Array of all binaries using union
  binary_list = allow_list | block_list
  binary_list.each do |binary|
    describe file("#{File.join(bin_dir, binary)}") do
      it { should exist}
      its('size') { should > 0 }
      it { should be_executable }
    end
  end

  allow_list.each do |binary|
    describe command("#{File.join(bin_dir, binary)} --version") do
      its('stdout') { should match /#{hab_pkg_path.stdout.strip.split('/')[5]}/ }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end
end
