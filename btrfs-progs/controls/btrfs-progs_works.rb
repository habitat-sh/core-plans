title 'Tests to confirm btrfs-progs works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'btrfs-progs')

control 'core-plans-btrfs-progs-works' do
  impact 1.0
  title 'Ensure btrfs-progs works as expected'
  desc '
  Verify btrfs-progs by ensuring that
  (1) its installation directory exists
  (2) btrfs returns the expected version
  (3) all other binaries return expected usage patterns.  Note that
  responses do not always follow a common pattern and exit statuses are not
  always zero.  The variations have been captured in a hash, therefore, below.
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  {
  "btrfs" => {
    pattern: /btrfs-progs v#{plan_pkg_version}/,
    command_suffix: "--version",
  },
  "btrfs-convert" => {
    pattern: /usage: btrfs-convert \[options\] device/,
    command_suffix: "--help",
  },
  "btrfs-find-root" => {
    pattern: /usage: btrfs-find-usage \[options\] <device>/,
    command_suffix: "--help",
  },
  "btrfs-image" => {
    pattern: /usage: btrfs-image \[options\] source target/,
    command_suffix: "--help",
  },
  "btrfs-map-logical" => {
    pattern: /usage: btrfs-map-logical \[options\] device/,
    command_suffix: "--help",
    exit_code_pattern:  /[^0]/,
  },
  "btrfs-select-super" => {
    pattern: /usage: btrfs-select-super -s number/,
    command_suffix: "--help",
    exit_code_pattern:  /[^0]/,
  },
  "btrfsck" => {
    pattern: /usage: btrfs check \[options\] <device>/,
    command_suffix: "--help",
  },
  "btrfstune" => {
    pattern: /usage: btrfstune \[options\] device/,
    command_suffix: "--help",
  },
  "fsck.btrfs" => {
    pattern: /If you wish to check the consistency of a BTRFS filesystem or\s+repair a damaged filesystem, see btrfs\(8\) subcommand 'check'/,
    command_suffix: "",
  },
  "mkfs.btrfs" => {
    pattern: /Usage: mkfs.btrfs \[options\] dev \[ dev ... \]/,
    command_suffix: "--help",
  },
  }.each do |binary_name, value|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    exit_code_pattern = value[:exit_code_pattern] || /[0]/
    compared_with = -> { its('exit_status') { should be == 0 } }
    describe command("#{command_full_path} #{value[:command_suffix]}") do
      its('exit_status') { should cmp exit_code_pattern }
      its('stdout') { should_not be_empty }
      its('stdout') { should match value[:pattern] }
    end
  end
end
