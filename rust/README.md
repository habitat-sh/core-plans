[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.rust?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=136&branchName=master)

# rust

Rust is a multi-paradigm system programming language focused on safety, especially safe concurrency. Rust is syntactically similar to C++, but is designed to provide better memory safety while maintaining high performance.  See [documentation](https://www.rust-lang.org)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/rust as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/rust)

##### Runtime dependency

> pkg_deps=(core/rust)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/rust --binlink``

will add the following binaries to the PATH:

* /bin/cargo
* /bin/cargo-clippy
* /bin/cargo-fmt
* /bin/cargo-miri
* /bin/cargo.real
* /bin/clippy-driver
* /bin/miri
* /bin/rls
* /bin/rust-gdb
* /bin/rust-gdbgui
* /bin/rust-lldb
* /bin/rustc
* /bin/rustdoc
* /bin/rustfmt

For example:

```bash
$ hab pkg install core/rust --binlink
» Installing core/rust
☁ Determining latest version of core/rust in the 'stable' channel
→ Found newer installed version (core/rust/1.43.1/20200612152403) than remote version (core/rust/1.43.1/20200601114117)
→ Using core/rust/1.43.1/20200612152403
★ Install of core/rust/1.43.1/20200612152403 complete with 0 new packages installed.
» Binlinking cargo-clippy from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked cargo-clippy from core/rust/1.43.1/20200612152403 to /bin/cargo-clippy
» Binlinking miri from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked miri from core/rust/1.43.1/20200612152403 to /bin/miri
» Binlinking rustdoc from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked rustdoc from core/rust/1.43.1/20200612152403 to /bin/rustdoc
» Binlinking cargo-miri from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked cargo-miri from core/rust/1.43.1/20200612152403 to /bin/cargo-miri
» Binlinking rustc from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked rustc from core/rust/1.43.1/20200612152403 to /bin/rustc
» Binlinking rls from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked rls from core/rust/1.43.1/20200612152403 to /bin/rls
» Binlinking cargo from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked cargo from core/rust/1.43.1/20200612152403 to /bin/cargo
» Binlinking rust-lldb from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked rust-lldb from core/rust/1.43.1/20200612152403 to /bin/rust-lldb
» Binlinking cargo-fmt from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked cargo-fmt from core/rust/1.43.1/20200612152403 to /bin/cargo-fmt
» Binlinking clippy-driver from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked clippy-driver from core/rust/1.43.1/20200612152403 to /bin/clippy-driver
» Binlinking rust-gdbgui from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked rust-gdbgui from core/rust/1.43.1/20200612152403 to /bin/rust-gdbgui
» Binlinking rustfmt from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked rustfmt from core/rust/1.43.1/20200612152403 to /bin/rustfmt
» Binlinking cargo.real from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked cargo.real from core/rust/1.43.1/20200612152403 to /bin/cargo.real
» Binlinking rust-gdb from core/rust/1.43.1/20200612152403 into /bin
★ Binlinked rust-gdb from core/rust/1.43.1/20200612152403 to /bin/rust-gdb
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/rustc --help`` or ``rustc --help``

```bash
$ rustc --help
Usage: rustc [OPTIONS] INPUT

Options:
    -h, --help          Display this message
        --cfg SPEC      Configure the compilation environment
    -L [KIND=]PATH      Add a directory to the library search path. The
                        optional KIND can be one of dependency, crate, native,
                        framework, or all (the default).
    -l [KIND=]NAME      Link the generated crate(s) to the specified native
...
...
```
