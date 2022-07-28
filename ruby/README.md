[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.ruby?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=280&branchName=master)

# ruby

A dynamic, open source programming language with a focus on   simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.  See [documentation](https://www.ruby-lang.org/en/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/ruby as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/ruby)

#### Runtime dependency

> pkg_deps=(core/ruby)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/ruby --binlink``

will add the following binaries to the PATH:

* /bin/bundle
* /bin/erb
* /bin/gem
* /bin/irb
* /bin/rake
* /bin/rdoc
* /bin/ri
* /bin/ruby
* /bin/update_rubygems

For example:

```bash
$ hab pkg install core/ruby --binlink
» Installing core/ruby
☁ Determining latest version of core/ruby in the 'stable' channel
→ Found newer installed version (core/ruby/2.5.8/20200928183217) than remote version (core/ruby/2.5.7/20200404130135)
→ Using core/ruby/2.5.8/20200928183217
★ Install of core/ruby/2.5.8/20200928183217 complete with 0 new packages installed.
» Binlinking irb from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked irb from core/ruby/2.5.8/20200928183217 to /bin/irb
» Binlinking ruby from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked ruby from core/ruby/2.5.8/20200928183217 to /bin/ruby
» Binlinking gem from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked gem from core/ruby/2.5.8/20200928183217 to /bin/gem
» Binlinking update_rubygems from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked update_rubygems from core/ruby/2.5.8/20200928183217 to /bin/update_rubygems
» Binlinking erb from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked erb from core/ruby/2.5.8/20200928183217 to /bin/erb
» Binlinking rdoc from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked rdoc from core/ruby/2.5.8/20200928183217 to /bin/rdoc
» Binlinking rake from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked rake from core/ruby/2.5.8/20200928183217 to /bin/rake
» Binlinking bundle from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked bundle from core/ruby/2.5.8/20200928183217 to /bin/bundle
» Binlinking ri from core/ruby/2.5.8/20200928183217 into /bin
★ Binlinked ri from core/ruby/2.5.8/20200928183217 to /bin/ri
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/ruby --help`` or ``ruby --help``

```bash
$ ruby --help
Usage: ruby [switches] [--] [programfile] [arguments]
  -0[octal]       specify record separator (\0, if no argument)
  -a              autosplit mode with -n or -p (splits $_ into $F)
  -c              check syntax only
  -Cdirectory     cd to directory before executing your script
  -d, --debug     set debugging flags (set $DEBUG to true)
  -e 'command'    one line of script. Several -e's allowed. Omit [programfile]
  -Eex[:in], --encoding=ex[:in]
...
...
```
