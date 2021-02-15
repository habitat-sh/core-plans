# dotnet-5-sdk

.NET is a free, cross-platform, open-source developer platform for building many different types of applications.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

```
hab pkg install core/dotnet-5-sdk
hab pkg exec core/dotnet-5-sdk dotnet --help
```

If using this as a dependency from another plan, you can include as a build or runtime dependency, and the `dotnet` cli will be automatically included in the path as necessary:

```
$pkg_deps=@("core/dotnet-5-sdk")
```
