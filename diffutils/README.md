[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.diffutils?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=124&branchName=master)

# diffutils

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/diffutils as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/diffutils)

##### Runtime Depdendency

> pkg_deps=(core/diffutils)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/diffutils --binlink``

will add the following binaries to the PATH:

* cmp
* diff
* diff3
* sdiff

```bash
$ hab pkg install core/diffutils --binlink
» Installing core/diffutils
☁ Determining latest version of core/diffutils in the 'stable' channel
☛ Verifying core/diffutils/3.7/20200306000423
→ Using core/glibc/2.29/20200305172459
→ Using core/linux-headers/4.19.62/20200305172241
✓ Installed core/diffutils/3.7/20200306000423
★ Install of core/diffutils/3.7/20200306000423 complete with 1 new packages installed.
» Binlinking cmp from core/diffutils/3.7/20200306000423 into /bin
★ Binlinked cmp from core/diffutils/3.7/20200306000423 to /bin/cmp
» Binlinking diff from core/diffutils/3.7/20200306000423 into /bin
★ Binlinked diff from core/diffutils/3.7/20200306000423 to /bin/diff
» Binlinking diff3 from core/diffutils/3.7/20200306000423 into /bin
★ Binlinked diff3 from core/diffutils/3.7/20200306000423 to /bin/diff3
» Binlinking sdiff from core/diffutils/3.7/20200306000423 into /bin
★ Binlinked sdiff from core/diffutils/3.7/20200306000423 to /bin/sdiff
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/diff --help`` or ``diff --help``

```bash
[54][default:/src:0]# diff --help
Usage: diff [OPTION]... FILES
Compare FILES line by line.

Mandatory arguments to long options are mandatory for short options too.
      --normal                  output a normal diff (the default)
  -q, --brief                   report only when files differ
  -s, --report-identical-files  report when two files are the same
  -c, -C NUM, --context[=NUM]   output NUM (default 3) lines of copied context
...
...
```
