[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.which?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=288&branchName=master)

# which

which is a utility that is used to find which executable (or alias or shell function) is executed when entered on the shell prompt.  See [documentation](https://savannah.gnu.org/projects/which)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/which as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/which)

#### Runtime dependency

> pkg_deps=(core/which)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/which --binlink``

will add the following binary to the PATH:

* /bin/which

For example:

```bash
$ hab pkg install core/which --binlink
» Installing core/which
☁ Determining latest version of core/which in the 'stable' channel
→ Found newer installed version (core/which/2.21/20200928133047) than remote version (core/which/2.21/20200403123400)
→ Using core/which/2.21/20200928133047
★ Install of core/which/2.21/20200928133047 complete with 0 new packages installed.
» Binlinking which from core/which/2.21/20200928133047 into /bin
★ Binlinked which from core/which/2.21/20200928133047 to /bin/which
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/which --help`` or ``which --help``

```bash
$ which --help
Usage: which [options] [--] COMMAND [...]
Write the full path of COMMAND(s) to standard output.

  --version, -[vV] Print version and exit successfully.
  --help,          Print this help and exit successfully.
  --skip-dot       Skip directories in PATH that start with a dot.
  --skip-tilde     Skip directories in PATH that start with a tilde.
  --show-dot       Don't expand a dot to current directory in output.
  --show-tilde     Output a tilde for HOME directory for non-root.
  --tty-only       Stop processing options on the right if not on tty.
  --all, -a        Print all matches in PATH, not just the first
  --read-alias, -i Read list of aliases from stdin.
  --skip-alias     Ignore option --read-alias; don't read stdin.
  --read-functions Read shell functions from stdin.
  --skip-functions Ignore option --read-functions; don't read stdin.
...
...
```
