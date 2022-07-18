[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.devicemapper?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=205&branchName=master)

# devicemapper

devicemapper, otherwise known as LVM2, refers to the userspace toolset that provide logical volume management facilities on linux.  See [documentation](https://sourceware.org/lvm2/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/devicemapper as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/devicemapper)

#### Runtime dependency

> pkg_deps=(core/devicemapper)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/devicemapper --binlink``

will add the following binaries to the PATH:

* /bin/blkdeactivate
* /bin/dmsetup
* /bin/dmstats
* /bin/fsadm
* /bin/lvchange
* /bin/lvconvert
* /bin/lvcreate
* /bin/lvdisplay
* /bin/lvextend
* /bin/lvm
* /bin/lvmconfig
* /bin/lvmdiskscan
* /bin/lvmdump
* /bin/lvmsadc
* /bin/lvmsar
* /bin/lvreduce
* /bin/lvremove
* /bin/lvrename
* /bin/lvresize
* /bin/lvs
* /bin/lvscan
* /bin/pvchange
* /bin/pvck
* /bin/pvcreate
* /bin/pvdisplay
* /bin/pvmove
* /bin/pvremove
* /bin/pvresize
* /bin/pvs
* /bin/pvscan
* /bin/vgcfgbackup
* /bin/vgcfgrestore
* /bin/vgchange
* /bin/vgck
* /bin/vgconvert
* /bin/vgcreate
* /bin/vgdisplay
* /bin/vgexport
* /bin/vgextend
* /bin/vgimport
* /bin/vgimportclone
* /bin/vgmerge
* /bin/vgmknodes
* /bin/vgreduce
* /bin/vgremove
* /bin/vgrename
* /bin/vgs
* /bin/vgscan
* /bin/vgsplit

For example:

```bash
$ hab pkg install core/devicemapper --binlink
» Installing core/devicemapper
☁ Determining latest version of core/devicemapper in the 'stable' channel
→ Found newer installed version (core/devicemapper/2.03.00/20200819152014) than remote version (core/devicemapper/2.03.00/20200511075902)
→ Using core/devicemapper/2.03.00/20200819152014
★ Install of core/devicemapper/2.03.00/20200819152014 complete with 0 new packages installed.
» Binlinking vgextend from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgextend from core/devicemapper/2.03.00/20200819152014 to /bin/vgextend
» Binlinking vgcfgrestore from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgcfgrestore from core/devicemapper/2.03.00/20200819152014 to /bin/vgcfgrestore
» Binlinking vgreduce from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgreduce from core/devicemapper/2.03.00/20200819152014 to /bin/vgreduce
» Binlinking pvscan from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvscan from core/devicemapper/2.03.00/20200819152014 to /bin/pvscan
» Binlinking vgscan from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgscan from core/devicemapper/2.03.00/20200819152014 to /bin/vgscan
» Binlinking vgmerge from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgmerge from core/devicemapper/2.03.00/20200819152014 to /bin/vgmerge
» Binlinking pvs from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvs from core/devicemapper/2.03.00/20200819152014 to /bin/pvs
» Binlinking vgrename from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgrename from core/devicemapper/2.03.00/20200819152014 to /bin/vgrename
» Binlinking lvcreate from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvcreate from core/devicemapper/2.03.00/20200819152014 to /bin/lvcreate
» Binlinking pvresize from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvresize from core/devicemapper/2.03.00/20200819152014 to /bin/pvresize
» Binlinking vgconvert from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgconvert from core/devicemapper/2.03.00/20200819152014 to /bin/vgconvert
» Binlinking blkdeactivate from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked blkdeactivate from core/devicemapper/2.03.00/20200819152014 to /bin/blkdeactivate
» Binlinking lvm from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvm from core/devicemapper/2.03.00/20200819152014 to /bin/lvm
» Binlinking fsadm from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked fsadm from core/devicemapper/2.03.00/20200819152014 to /bin/fsadm
» Binlinking lvresize from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvresize from core/devicemapper/2.03.00/20200819152014 to /bin/lvresize
» Binlinking vgremove from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgremove from core/devicemapper/2.03.00/20200819152014 to /bin/vgremove
» Binlinking pvck from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvck from core/devicemapper/2.03.00/20200819152014 to /bin/pvck
» Binlinking vgdisplay from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgdisplay from core/devicemapper/2.03.00/20200819152014 to /bin/vgdisplay
» Binlinking pvdisplay from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvdisplay from core/devicemapper/2.03.00/20200819152014 to /bin/pvdisplay
» Binlinking vgs from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgs from core/devicemapper/2.03.00/20200819152014 to /bin/vgs
» Binlinking lvs from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvs from core/devicemapper/2.03.00/20200819152014 to /bin/lvs
» Binlinking vgexport from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgexport from core/devicemapper/2.03.00/20200819152014 to /bin/vgexport
» Binlinking dmsetup from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked dmsetup from core/devicemapper/2.03.00/20200819152014 to /bin/dmsetup
» Binlinking lvmsadc from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvmsadc from core/devicemapper/2.03.00/20200819152014 to /bin/lvmsadc
» Binlinking vgsplit from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgsplit from core/devicemapper/2.03.00/20200819152014 to /bin/vgsplit
» Binlinking lvchange from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvchange from core/devicemapper/2.03.00/20200819152014 to /bin/lvchange
» Binlinking lvmdump from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvmdump from core/devicemapper/2.03.00/20200819152014 to /bin/lvmdump
» Binlinking lvmconfig from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvmconfig from core/devicemapper/2.03.00/20200819152014 to /bin/lvmconfig
» Binlinking pvchange from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvchange from core/devicemapper/2.03.00/20200819152014 to /bin/pvchange
» Binlinking lvremove from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvremove from core/devicemapper/2.03.00/20200819152014 to /bin/lvremove
» Binlinking lvdisplay from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvdisplay from core/devicemapper/2.03.00/20200819152014 to /bin/lvdisplay
» Binlinking lvmdiskscan from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvmdiskscan from core/devicemapper/2.03.00/20200819152014 to /bin/lvmdiskscan
» Binlinking vgimportclone from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgimportclone from core/devicemapper/2.03.00/20200819152014 to /bin/vgimportclone
» Binlinking vgimport from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgimport from core/devicemapper/2.03.00/20200819152014 to /bin/vgimport
» Binlinking vgcreate from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgcreate from core/devicemapper/2.03.00/20200819152014 to /bin/vgcreate
» Binlinking lvreduce from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvreduce from core/devicemapper/2.03.00/20200819152014 to /bin/lvreduce
» Binlinking dmstats from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked dmstats from core/devicemapper/2.03.00/20200819152014 to /bin/dmstats
» Binlinking pvmove from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvmove from core/devicemapper/2.03.00/20200819152014 to /bin/pvmove
» Binlinking vgcfgbackup from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgcfgbackup from core/devicemapper/2.03.00/20200819152014 to /bin/vgcfgbackup
» Binlinking lvconvert from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvconvert from core/devicemapper/2.03.00/20200819152014 to /bin/lvconvert
» Binlinking pvcreate from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvcreate from core/devicemapper/2.03.00/20200819152014 to /bin/pvcreate
» Binlinking lvextend from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvextend from core/devicemapper/2.03.00/20200819152014 to /bin/lvextend
» Binlinking pvremove from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked pvremove from core/devicemapper/2.03.00/20200819152014 to /bin/pvremove
» Binlinking lvrename from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvrename from core/devicemapper/2.03.00/20200819152014 to /bin/lvrename
» Binlinking vgchange from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgchange from core/devicemapper/2.03.00/20200819152014 to /bin/vgchange
» Binlinking lvscan from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvscan from core/devicemapper/2.03.00/20200819152014 to /bin/lvscan
» Binlinking vgmknodes from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgmknodes from core/devicemapper/2.03.00/20200819152014 to /bin/vgmknodes
» Binlinking lvmsar from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked lvmsar from core/devicemapper/2.03.00/20200819152014 to /bin/lvmsar
» Binlinking vgck from core/devicemapper/2.03.00/20200819152014 into /bin
★ Binlinked vgck from core/devicemapper/2.03.00/20200819152014 to /bin/vgck
```

 core/devicemapper as a stand alone binary, you must configure ...

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/vgs --help`` or ``vgs --help``

```bash
$ vgs --help
  vgs - Display information about volume groups

  vgs
        [ -a|--all ]
        [ -o|--options String ]
        [ -S|--select String ]
        [ -O|--sort String ]
        [    --aligned ]
        [    --binary ]
...
...
```
