title 'Tests to confirm gcc works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "gcc")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-gcc' do
  impact 1.0
  title 'Ensure gcc is working as expected'
  desc '
  We first check that the gcc.real executable is present and then runs version checks to verify that the binary is executable.

  stderr tests are not included due to an issue with hab
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  gcc_exists = command("ls -al #{File.join(target_dir, "gcc")}")
  describe gcc_exists do
    its('stdout') { should match /gcc/ }
    its('exit_status') { should eq 0 }
  end

  gcc_version = command("#{target_dir}/gcc --version")
  describe gcc_version do
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 0 }
  end

  gcc_real_exists = command("ls -al #{File.join(target_dir, "gcc.real")}")
  describe gcc_real_exists do
    its('stdout') { should match /gcc.real/ }
    its('exit_status') { should eq 0 }
  end

  gcc_real_version = command("#{target_dir}/gcc.real --version")
  describe gcc_real_version do
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 0 }
  end
end
