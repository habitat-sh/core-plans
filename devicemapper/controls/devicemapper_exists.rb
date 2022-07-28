title 'Tests to confirm devicemapper exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'devicemapper')

control 'core-plans-devicemapper-exists' do
  impact 1.0
  title 'Ensure devicemapper exists'
  desc '
  Verify devicemapper by ensuring bin/vgs
  (1) exists and
  (2) is executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
    "blkdeactivate",
    "dmsetup",
    "dmstats",
    "fsadm",
    "lvchange",
    "lvconvert",
    "lvcreate",
    "lvdisplay",
    "lvextend",
    "lvm",
    "lvmconfig",
    "lvmdiskscan",
    "lvmdump",
    "lvmsadc",
    "lvmsar",
    "lvreduce",
    "lvremove",
    "lvrename",
    "lvresize",
    "lvs",
    "lvscan",
    "pvchange",
    "pvck",
    "pvcreate",
    "pvdisplay",
    "pvmove",
    "pvremove",
    "pvresize",
    "pvs",
    "pvscan",
    "vgcfgbackup",
    "vgcfgrestore",
    "vgchange",
    "vgck",
    "vgconvert",
    "vgcreate",
    "vgdisplay",
    "vgexport",
    "vgextend",
    "vgimport",
    "vgimportclone",
    "vgmerge",
    "vgmknodes",
    "vgreduce",
    "vgremove",
    "vgrename",
    "vgs",
    "vgscan",
    "vgsplit",
    ].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "sbin", binary_name)
      describe file(command_full_path) do
        it { should exist }
        it { should be_executable }
      end
    end
end
