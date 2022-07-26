[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.grep?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=69&branchName=master)

# grep

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/grep as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/grep)

##### Runtime Depdendency

> pkg_deps=(core/grep)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/grep`

> » Installing core/grep
>
> ☁ Determining latest version of core/grep in the 'stable' channel
>
> ☛ Verifying core/grep/3.3/20200305232635
>
> ...
>
> ✓ Installed core/grep/3.3/20200305232635
>
> ★ Install of core/grep/3.3/20200305232635 complete with 1 new packages installed.

`hab pkg binlink core/grep`

> » Binlinking fgrep from core/grep into /bin
>
> ★ Binlinked fgrep from core/grep/3.3/20200305232635 to /bin/fgrep

#### Using an example binary
You can now use the binary as normal:

`/bin/grep --help` or `grep --help`

```
Usage: grep [OPTION]... PATTERNS [FILE]...
Search for PATTERNS in each FILE.
Example: grep -i 'hello world' menu.h main.c
PATTERNS can contain multiple patterns separated by newlines.

Pattern selection and interpretation:
  -E, --extended-regexp     PATTERNS are extended regular expressions
  -F, --fixed-strings       PATTERNS are strings
  -G, --basic-regexp        PATTERNS are basic regular expressions
  -P, --perl-regexp         PATTERNS are Perl regular expressions
  -e, --regexp=PATTERNS     use PATTERNS for matching
...
```
