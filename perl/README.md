[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.perl?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=130&branchName=master)

# perl

Perl is a highly capable, feature-rich programming language with over 30 years of development.  See [documentation](https://www.perl.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/perl as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/perl)

##### Runtime dependency

> pkg_deps=(core/perl)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/perl --binlink``

will add the following binaries to the PATH:

* /bin/corelist
* /bin/cpan
* /bin/enc2xs
* /bin/encguess
* /bin/h2ph
* /bin/h2xs
* /bin/instmodsh
* /bin/json_pp
* /bin/libnetcfg
* /bin/perl
* /bin/perl5.30.0
* /bin/perlbug
* /bin/perldoc
* /bin/perlivp
* /bin/perlthanks
* /bin/piconv
* /bin/pl2pm
* /bin/pod2html
* /bin/pod2man
* /bin/pod2text
* /bin/pod2usage
* /bin/podchecker
* /bin/podselect
* /bin/prove
* /bin/ptar
* /bin/ptardiff
* /bin/ptargrep
* /bin/shasum
* /bin/splain
* /bin/xsubpp
* /bin/zipdetails

For example:

```bash
$ hab pkg install core/perl --binlink
» Installing core/perl
☁ Determining latest version of core/perl in the 'stable' channel
→ Found newer installed version (core/perl/5.30.0/20200611185023) than remote version (core/perl/5.30.0/20200305235250)
→ Using core/perl/5.30.0/20200611185023
★ Install of core/perl/5.30.0/20200611185023 complete with 0 new packages installed.
» Binlinking perl from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked perl from core/perl/5.30.0/20200611185023 to /bin/perl
» Binlinking perlbug from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked perlbug from core/perl/5.30.0/20200611185023 to /bin/perlbug
» Binlinking pod2html from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked pod2html from core/perl/5.30.0/20200611185023 to /bin/pod2html
» Binlinking splain from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked splain from core/perl/5.30.0/20200611185023 to /bin/splain
» Binlinking libnetcfg from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked libnetcfg from core/perl/5.30.0/20200611185023 to /bin/libnetcfg
» Binlinking podchecker from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked podchecker from core/perl/5.30.0/20200611185023 to /bin/podchecker
» Binlinking ptar from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked ptar from core/perl/5.30.0/20200611185023 to /bin/ptar
» Binlinking perldoc from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked perldoc from core/perl/5.30.0/20200611185023 to /bin/perldoc
» Binlinking perlivp from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked perlivp from core/perl/5.30.0/20200611185023 to /bin/perlivp
» Binlinking pod2text from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked pod2text from core/perl/5.30.0/20200611185023 to /bin/pod2text
» Binlinking perl5.30.0 from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked perl5.30.0 from core/perl/5.30.0/20200611185023 to /bin/perl5.30.0
» Binlinking shasum from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked shasum from core/perl/5.30.0/20200611185023 to /bin/shasum
» Binlinking cpan from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked cpan from core/perl/5.30.0/20200611185023 to /bin/cpan
» Binlinking podselect from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked podselect from core/perl/5.30.0/20200611185023 to /bin/podselect
» Binlinking json_pp from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked json_pp from core/perl/5.30.0/20200611185023 to /bin/json_pp
» Binlinking ptargrep from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked ptargrep from core/perl/5.30.0/20200611185023 to /bin/ptargrep
» Binlinking zipdetails from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked zipdetails from core/perl/5.30.0/20200611185023 to /bin/zipdetails
» Binlinking enc2xs from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked enc2xs from core/perl/5.30.0/20200611185023 to /bin/enc2xs
» Binlinking h2xs from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked h2xs from core/perl/5.30.0/20200611185023 to /bin/h2xs
» Binlinking pod2usage from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked pod2usage from core/perl/5.30.0/20200611185023 to /bin/pod2usage
» Binlinking ptardiff from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked ptardiff from core/perl/5.30.0/20200611185023 to /bin/ptardiff
» Binlinking perlthanks from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked perlthanks from core/perl/5.30.0/20200611185023 to /bin/perlthanks
» Binlinking prove from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked prove from core/perl/5.30.0/20200611185023 to /bin/prove
» Binlinking corelist from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked corelist from core/perl/5.30.0/20200611185023 to /bin/corelist
» Binlinking encguess from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked encguess from core/perl/5.30.0/20200611185023 to /bin/encguess
» Binlinking xsubpp from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked xsubpp from core/perl/5.30.0/20200611185023 to /bin/xsubpp
» Binlinking piconv from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked piconv from core/perl/5.30.0/20200611185023 to /bin/piconv
» Binlinking h2ph from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked h2ph from core/perl/5.30.0/20200611185023 to /bin/h2ph
» Binlinking pod2man from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked pod2man from core/perl/5.30.0/20200611185023 to /bin/pod2man
» Binlinking instmodsh from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked instmodsh from core/perl/5.30.0/20200611185023 to /bin/instmodsh
» Binlinking pl2pm from core/perl/5.30.0/20200611185023 into /bin
★ Binlinked pl2pm from core/perl/5.30.0/20200611185023 to /bin/pl2pm
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/perl --help`` or ``perl --help``

```bash
$ perl --help/src/perl:0t:Usage: perl [switches] [--] [programfile] [arguments]
  -0[octal]         specify record separator (\0, if no argument)
  -a                autosplit mode with -n or -p (splits $_ into @F)
  -C[number/list]   enables the listed Unicode features
  -c                check syntax only (runs BEGIN and CHECK blocks)
  -d[:debugger]     run program under debugger
...
...
```
