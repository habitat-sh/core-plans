[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.protobuf-cpp?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=181&branchName=master)

# protobuf-cpp

Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/protobuf-cpp as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/protobuf-cpp)

##### Runtime Depdendency

> pkg_deps=(core/protobuf-cpp)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/protobuf-cpp`

> » Installing core/protobuf-cpp
>
> ☁ Determining latest version of core/protobuf-cpp in the 'stable' channel
>
> ☛ Verifying core/protobuf-cpp/3.9.2/20200622090120
> ...
>
> ✓ Installed core/protobuf-cpp/3.9.2/20200622090120
>
> ★ Install of core/protobuf-cpp/3.9.2/20200622090120 complete with 1 new packages installed.

`hab pkg binlink core/protobuf-cpp`

> » Binlinking protoc from core/protobuf-cpp into /bin
>
> ★ Binlinked protoc from core/protobuf-cpp/3.9.2/20200622090120 to /bin/protoc

#### Using an example binary
You can now use the binary as normal:

`/bin/protoc --help` or `protoc --help`

```
Usage: protoc [OPTION] PROTO_FILES
Parse PROTO_FILES and generate output based on the options given:
  -IPATH, --proto_path=PATH   Specify the directory in which to search for
                              imports.  May be specified multiple times;
                              directories will be searched in order.  If not
                              given, the current working directory is used.
                              If not found in any of the these directories,
                              the --descriptor_set_in descriptors will be
                              checked for required proto file.
  --version                   Show version info and exit.
  -h, --help                  Show this text and exit.
...
```
