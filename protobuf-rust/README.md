[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.protobuf-rust?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=182&branchName=master)

# protobuf-rust

Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.  **protobuf-rust** contains an executable that must be used in conjuction with the protobuf toolset and is specific to rust.  See [documentation](https://developers.google.com/protocol-buffers/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/protobuf-rust as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/protobuf-rust)

##### Runtime dependency

> pkg_deps=(core/protobuf-rust)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/protobuf-rust --binlink``

will add the following binaries to the PATH:

* /bin/protobuf-bin-gen-rust-do-not-use
* /bin/protoc-gen-rust

For example:

```bash
$ hab pkg install core/protobuf-rust --binlink
» Installing core/protobuf-rust
☁ Determining latest version of core/protobuf-rust in the 'stable' channel
→ Found newer installed version (core/protobuf-rust/1.7.4/20200625153139) than remote version (core/protobuf-rust/1.7.4/20200319203941)
→ Using core/protobuf-rust/1.7.4/20200625153139
★ Install of core/protobuf-rust/1.7.4/20200625153139 complete with 0 new packages installed.
» Binlinking protobuf-bin-gen-rust-do-not-use from core/protobuf-rust/1.7.4/20200625153139 into /bin
★ Binlinked protobuf-bin-gen-rust-do-not-use from core/protobuf-rust/1.7.4/20200625153139 to /bin/protobuf-bin-gen-rust-do-not-use
» Binlinking protoc-gen-rust from core/protobuf-rust/1.7.4/20200625153139 into /bin
★ Binlinked protoc-gen-rust from core/protobuf-rust/1.7.4/20200625153139 to /bin/protoc-gen-rust
```

#### Using an example binary

The protobuf-rust binaries cannot be used on their own but must be used in the context of protobuf.
