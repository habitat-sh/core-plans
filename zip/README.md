[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.zip?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=294&branchName=master)

# zip

Zip is a compression and file packaging/archive utility.  See [documentation](http://infozip.sourceforge.net/Zip.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/zip as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/zip)

#### Runtime dependency

> pkg_deps=(core/zip)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/zip --binlink``

will add the following binaries to the PATH:

* /bin/zip
* /bin/zipcloak
* /bin/zipnote
* /bin/zipsplit

For example:

```bash
$ hab pkg install core/zip --binlink
» Installing core/zip
☁ Determining latest version of core/zip in the 'stable' channel
→ Found newer installed version (core/zip/3.0/20200928102817) than remote version (core/zip/3.0/20200404025312)
→ Using core/zip/3.0/20200928102817
★ Install of core/zip/3.0/20200928102817 complete with 0 new packages installed.
» Binlinking zipcloak from core/zip/3.0/20200928102817 into /bin
★ Binlinked zipcloak from core/zip/3.0/20200928102817 to /bin/zipcloak
» Binlinking zip from core/zip/3.0/20200928102817 into /bin
★ Binlinked zip from core/zip/3.0/20200928102817 to /bin/zip
» Binlinking zipsplit from core/zip/3.0/20200928102817 into /bin
★ Binlinked zipsplit from core/zip/3.0/20200928102817 to /bin/zipsplit
» Binlinking zipnote from core/zip/3.0/20200928102817 into /bin
★ Binlinked zipnote from core/zip/3.0/20200928102817 to /bin/zipnote
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/zip -h`` or ``zip -h``

```bash
$ zip --help
Copyright (c) 1990-2008 Info-ZIP - Type 'zip "-L"' for software license.
Zip 3.0 (July 5th 2008). Usage:
zip [-options] [-b path] [-t mmddyyyy] [-n suffixes] [zipfile list] [-xi list]
  The default action is to add or replace zipfile entries from list, which
  can include the special name - to compress standard input.
  If zipfile and list are omitted, zip compresses stdin to stdout.
  -f   freshen: only changed files  -u   update: only changed or new files
  -d   delete entries in zipfile    -m   move into zipfile (delete OS files)
  -r   recurse into directories     -j   junk (don't record) directory names
  -0   store only                   -l   convert LF to CR LF (-ll CR LF to LF)
  -1   compress faster              -9   compress better
  -q   quiet operation              -v   verbose operation/print version info
  -c   add one-line comments        -z   add zipfile comment
  -@   read names from stdin        -o   make zipfile as old as latest entry
  -x   exclude the following names  -i   include only the following names
  -F   fix zipfile (-FF try harder) -D   do not add directory entries
  -A   adjust self-extracting exe   -J   junk zipfile prefix (unzipsfx)
  -T   test zipfile integrity       -X   eXclude eXtra file attributes
  -y   store symbolic links as the link instead of the referenced file
  -e   encrypt                      -n   don't compress these suffixes
  -h2  show more help
```
