[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.protobuf?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=133&branchName=master)

# protobuf

Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data.  See [documentation](https://developers.google.com/protocol-buffers/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/protobuf as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/protobuf)

##### Runtime dependency

> pkg_deps=(core/protobuf)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/protobuf --binlink``

will add the following binary to the PATH:

* /bin/protoc

For example:

```bash
$ hab pkg install core/protobuf --binlink
» Installing core/protobuf
☁ Determining latest version of core/protobuf in the 'stable' channel
☛ Verifying core/protobuf/3.9.2/20200310022658
...
...
✓ Installed core/protobuf/3.9.2/20200310022658
★ Install of core/protobuf/3.9.2/20200310022658 complete with 4 new packages installed.
» Binlinking protoc from core/protobuf/3.9.2/20200310022658 into /bin
★ Binlinked protoc from core/protobuf/3.9.2/20200310022658 to /bin/protoc
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/protoc --help`` or ``protoc --help``

```bash
$ protoc --help
Usage: protoc [OPTION] PROTO_FILES
Parse PROTO_FILES and generate output based on the options given:
  -IPATH, --proto_path=PATH   Specify the directory in which to search for
                              imports.  May be specified multiple times;
...
...
```
