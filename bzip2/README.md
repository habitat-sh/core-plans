[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.bzip2?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=94&branchName=master)

# bzip2

bzip2 is a free and open-source file compression program that uses the Burrows–Wheeler algorithm. It only compresses single files and is not a file archiver.  See [documentation](https://sourceware.org/bzip2/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/bzip2 as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/bzip2)

##### Runtime dependency

> pkg_deps=(core/bzip2)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/bzip2 --binlink``

will add the following binaries to the PATH:

* /bin/bzdiff
* /bin/bzip2
* /bin/bunzip2
* /bin/bzegrep
* /bin/bzless
* /bin/bzip2recover
* /bin/bzcat
* /bin/bzcmp
* /bin/bzgrep
* /bin/bzmore
* /bin/bzfgrep

For example:

```bash
$ hab pkg install core/bzip2 --binlink
» Installing core/bzip2
☁ Determining latest version of core/bzip2 in the 'stable' channel
→ Found newer installed version (core/bzip2/1.0.8/20200602211701) than remote version (core/bzip2/1.0.8/20200305225842)
→ Using core/bzip2/1.0.8/20200602211701
★ Install of core/bzip2/1.0.8/20200602211701 complete with 0 new packages installed.
» Binlinking bzdiff from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzdiff from core/bzip2/1.0.8/20200602211701 to /bin/bzdiff
» Binlinking bzip2 from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzip2 from core/bzip2/1.0.8/20200602211701 to /bin/bzip2
» Binlinking bunzip2 from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bunzip2 from core/bzip2/1.0.8/20200602211701 to /bin/bunzip2
» Binlinking bzegrep from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzegrep from core/bzip2/1.0.8/20200602211701 to /bin/bzegrep
» Binlinking bzless from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzless from core/bzip2/1.0.8/20200602211701 to /bin/bzless
» Binlinking bzip2recover from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzip2recover from core/bzip2/1.0.8/20200602211701 to /bin/bzip2recover
» Binlinking bzcat from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzcat from core/bzip2/1.0.8/20200602211701 to /bin/bzcat
» Binlinking bzcmp from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzcmp from core/bzip2/1.0.8/20200602211701 to /bin/bzcmp
» Binlinking bzgrep from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzgrep from core/bzip2/1.0.8/20200602211701 to /bin/bzgrep
» Binlinking bzmore from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzmore from core/bzip2/1.0.8/20200602211701 to /bin/bzmore
» Binlinking bzfgrep from core/bzip2/1.0.8/20200602211701 into /bin
★ Binlinked bzfgrep from core/bzip2/1.0.8/20200602211701 to /bin/bzfgrep
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/bzip2 --help`` or ``bzip2 --help``

```bash
$ bzip2 --help
bzip2, a block-sorting file compressor.  Version 1.0.6, 6-Sept-2010.

   usage: bzip2 [flags and input files in any order]

   -h --help           print this message
   -d --decompress     force decompression
   -z --compress       force compression
   -k --keep           keep (don't delete) input files
   -f --force          overwrite existing output files
...
...
```
