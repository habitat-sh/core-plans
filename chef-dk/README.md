# chef-dk

The `chef-dk` plan packages the binaries contained in the Chef Development Kit.

## Maintainers

The Habitat Maintainers humans@habitat.sh


## Type of Package

A Binary package

## Usage

Include this plan in your build or runtime dependencies:

```
$pkg_deps=@("core/chef-dk")
```

Then use any of the `chef-dk` utilities in your plan or hooks:

```
chef-client -z
```
