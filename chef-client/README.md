# chef-client

The `chef-client` plan packages the binaries contained in the Chef Client.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package 

A Binary package

## Usage

Include this plan in your build or runtime dependencies:

```
$pkg_deps=@("core/chef-client")
```

Then use the chef-client in your plan or hooks:

```
chef-client.bat -z
```