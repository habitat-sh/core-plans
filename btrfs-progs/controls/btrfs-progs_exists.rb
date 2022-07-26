title 'Tests to confirm btrfs-progs exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'btrfs-progs')

control 'core-plans-btrfs-progs-exists' do
  impact 1.0
  title 'Ensure btrfs-progs exists'
  desc '
  Verify btrfs-progs by ensuring all binaries
  (1) exist and
  (2) are executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
  "btrfs",
  "btrfs-convert",
  "btrfs-find-root",
  "btrfs-image",
  "btrfs-map-logical",
  "btrfs-select-super",
  "btrfsck",
  "btrfstune",
  "fsck.btrfs",
  "mkfs.btrfs",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
