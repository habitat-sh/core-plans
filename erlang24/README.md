[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.erlang24?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=227&branchName=master)

# erlang24

Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability. Some of its uses are in telecoms, banking, e-commerce, computer telephony and instant messaging. See [documentation](https://www.erlang.org/docs)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/erlang24 as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/erlang24)

#### Runtime dependency

> pkg_deps=(core/erlang24)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/erlang24 --binlink``

will add the following binaries to the PATH:

* /bin/ct_run
* /bin/dialyzer
* /bin/epmd
* /bin/erl
* /bin/erlc
* /bin/escript
* /bin/run_erl
* /bin/to_erl
* /bin/typer

For example:

```bash
$ hab pkg install core/erlang24 --binlink
» Installing core/erlang24
☁ Determining latest version of core/erlang24 in the 'stable' channel
→ Found newer installed version (core/erlang24/24.3.4.2/20220719061812) than remote version (core/erlang24/24.3.4.2/20220719061812)
→ Using core/erlang24/24.3.4.2/20220719061812
★ Install of core/erlang24/24.3.4.2/20220719061812 complete with 0 new packages installed.
» Binlinking epmd from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked epmd from core/erlang24/24.3.4.2/20220719061812 to /bin/epmd
» Binlinking typer from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked typer from core/erlang24/24.3.4.2/20220719061812 to /bin/typer
» Binlinking ct_run from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked ct_run from core/erlang24/24.3.4.2/20220719061812 to /bin/ct_run
» Binlinking to_erl from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked to_erl from core/erlang24/24.3.4.2/20220719061812 to /bin/to_erl
» Binlinking run_erl from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked run_erl from core/erlang24/24.3.4.2/20220719061812 to /bin/run_erl
» Binlinking erl from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked erl from core/erlang24/24.3.4.2/20220719061812 to /bin/erl
» Binlinking dialyzer from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked dialyzer from core/erlang24/24.3.4.2/20220719061812 to /bin/dialyzer
» Binlinking escript from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked escript from core/erlang24/24.3.4.2/20220719061812 to /bin/escript
» Binlinking erlc from core/erlang24/24.3.4.2/20220719061812 into /bin
★ Binlinked erlc from core/erlang24/24.3.4.2/20220719061812 to /bin/erlc

```

#### Using an example binary

You can now use the binary as normal.  For example, save the following erlang script and call it ``hello``:

```erlang
#!/usr/bin/env escript
-export([main/1]).
main([]) -> io:format("Hello, World!~n").
```

Then do the following:

``/bin/escript hello`` or ``escript hello``

```bash
$ escript hello
Hello, World!
```
