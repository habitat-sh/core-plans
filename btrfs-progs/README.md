[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.btrfs-progs?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=197&branchName=master)

# btrfs-progs

btrfs is a modern copy on write (CoW) filesystem for Linux aimed at
implementing advanced features while also focusing on fault tolerance,
repair and easy administration.  See [documentation](https://btrfs.wiki.kernel.org/index.php/Main_Page
)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/btrfs-progs as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/btrfs-progs)

##### Runtime dependency

> pkg_deps=(core/btrfs-progs)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/btrfs-progs --binlink``

will add the following binaries to the PATH:

* /bin/btrfs
* /bin/btrfs-convert
* /bin/btrfs-find-root
* /bin/btrfs-image
* /bin/btrfs-map-logical
* /bin/btrfs-select-super
* /bin/btrfsck
* /bin/btrfstune
* /bin/fsck.btrfs
* /bin/mkfs.btrfs

For example:

```bash
$ hab pkg install core/btrfs-progs --binlink
» Installing core/btrfs-progs
☁ Determining latest version of core/btrfs-progs in the 'stable' channel
→ Found newer installed version (core/btrfs-progs/5.6.1/20200813124048) than remote version (core/btrfs-progs/5.6.1/20200511101935)
→ Using core/btrfs-progs/5.6.1/20200813124048
★ Install of core/btrfs-progs/5.6.1/20200813124048 complete with 0 new packages installed.
» Binlinking btrfs-find-root from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfs-find-root from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfs-find-root
» Binlinking btrfs-select-super from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfs-select-super from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfs-select-super
» Binlinking btrfs-image from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfs-image from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfs-image
» Binlinking fsck.btrfs from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked fsck.btrfs from core/btrfs-progs/5.6.1/20200813124048 to /bin/fsck.btrfs
» Binlinking btrfstune from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfstune from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfstune
» Binlinking btrfs-convert from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfs-convert from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfs-convert
» Binlinking mkfs.btrfs from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked mkfs.btrfs from core/btrfs-progs/5.6.1/20200813124048 to /bin/mkfs.btrfs
» Binlinking btrfsck from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfsck from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfsck
» Binlinking btrfs-map-logical from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfs-map-logical from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfs-map-logical
» Binlinking btrfs from core/btrfs-progs/5.6.1/20200813124048 into /bin
★ Binlinked btrfs from core/btrfs-progs/5.6.1/20200813124048 to /bin/btrfs
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/btrfs --help`` or ``btrfs --help``

```bash
$ btrfs --help
usage: btrfs [--help] [--version] [--format <format>] <group> [<group>...] <command> [<args>]

    btrfs subvolume create [-i <qgroupid>] [<dest>/]<name>
        Create a subvolume
    btrfs subvolume delete [options] <subvolume> [<subvolume>...]
    btrfs subvolume delete [options] -i|--subvolid <subvolid> <path>
        Delete subvolume(s)
...
...
```
