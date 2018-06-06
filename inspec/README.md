# inspec

The `inspec` plan packages the binaries contained in the InSpec client.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

A Binary package

## Usage

Include this plan in your build or runtime dependencies:

```
$pkg_deps=@("core/inspec")
```

Then use InSpec in your plan or hooks:

```
{{pkgPathFor "core/inspec"}}/bin/inspec.bat exec
```
