title 'Tests to confirm xxhash works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'xxhash')
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-xxhash-works' do
  impact 1.0
  title 'Ensure xxhash works as expected'
  desc '
  Verify xxhash by ensuring that
  (1) its installation directory exists
  (2) it returns the expected version
    $ $PKG_PATH/bin/xxhsum --version
      xxhsum 0.8.0 by Yann Collet
      compiled as 64-bit x86_64 + SSE2 little endian with GCC 9.1.0'

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  command_full_path = File.join(hab_pkg_path.stdout.strip, "bin", "xxhsum")
  # redirect stderr to stdout.
  describe command("#{command_full_path} --version 2>&1") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /xxhsum #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
  end
end
