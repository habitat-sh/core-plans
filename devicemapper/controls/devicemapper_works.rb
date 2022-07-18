title 'Tests to confirm devicemapper works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'devicemapper')

control 'core-plans-devicemapper-works' do
  impact 1.0
  title 'Ensure devicemapper works as expected'
  desc '
  Verify devicemapper by ensuring that
  (1) its installation directory exists
  (2) expected version is returned by some binaries
  (3) expected help response is returned by the rest

  NOTE:
  *) Some binaries like "fsadm" and "lvmdump" cannot be run
  simply as a raw binary but must have their $PATH environment setup
  as well to make available other utilities like "lvm".  For these tests
  the "hab pkg exec core/devicemapper" must prefix the binary
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  full_suite = {
    "blkdeactivate" => {
      command_suffix: "-h",
      command_output_pattern: /blkdeactivate\s+\[options\]\s+\[device...\]/
    },
    "dmsetup" => {
      command_suffix: "help 2>&1",
      command_output_pattern: /Usage:\s+dmsetup\s+\[--version\]/
    },
    "dmstats" => {
      command_suffix: "help 2>&1",
      command_output_pattern: /Usage:\s+dmstats\s+\[-h\|--help\]/
    },
    "fsadm" => {
      command_prefix: "hab pkg exec #{plan_origin}/#{plan_name} --",
      command_suffix: "--help 2>&1",
      command_output_pattern: /fsadm: Utility to resize or check the filesystem on a device/
    },
    "lvchange" => {},
    "lvconvert" => {},
    "lvcreate" => {},
    "lvdisplay" => {},
    "lvextend" => {},
    "lvm" => {
      command_suffix: "version",
      command_output_pattern: /LVM version:\s+#{plan_pkg_version}/
    },
    "lvmconfig" => {},
    "lvmdiskscan" => {},
    "lvmdump" => {
      command_prefix: "hab pkg exec #{plan_origin}/#{plan_name} --",
      command_suffix: "-h 2>&1",
      command_output_pattern: /lvmdump\s+\[options\]/,
      exit_pattern: /^[^0]$/,
    },
    "lvmsadc" => {},
    "lvmsar" => {},
    "lvreduce" => {},
    "lvremove" => {},
    "lvrename" => {},
    "lvresize" => {},
    "lvs" => {},
    "lvscan" => {},
    "pvchange" => {},
    "pvck" => {},
    "pvcreate" => {},
    "pvdisplay" => {},
    "pvmove" => {},
    "pvremove" => {},
    "pvresize" => {},
    "pvs" => {},
    "pvscan" => {},
    "vgcfgbackup" => {},
    "vgcfgrestore" => {},
    "vgchange" => {},
    "vgck" => {},
    "vgconvert" => {},
    "vgcreate" => {},
    "vgdisplay" => {},
    "vgexport" => {},
    "vgextend" => {},
    "vgimport" => {},
    "vgimportclone" => {},
    "vgmerge" => {},
    "vgmknodes" => {},
    "vgreduce" => {},
    "vgremove" => {},
    "vgrename" => {},
    "vgs" => {
      command_suffix: "--version",
      command_output_pattern: /LVM version:\s+#{plan_pkg_version}/
    },
    "vgscan" => {},
    "vgsplit" => {},
  }

  # Use the following to pull out a subset of the above and test progressively
  subset = full_suite.select { |key, value| key.to_s.match(/^.*$/) }

  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    command_prefix = value[:command_prefix] || ""
    command_suffix = value[:command_suffix] || "--help"
    command_output_pattern = value[:command_output_pattern] || /#{binary_name} -/
    exit_pattern = value[:exit_pattern] || /^0$/ # use /^[^0]$/ for non-zero exit status
    command_full_path = File.join(plan_installation_directory.stdout.strip, "sbin", binary_name)
    describe bash("#{command_prefix} #{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its("stdout") { should match command_output_pattern }
    end
  end
  
end
