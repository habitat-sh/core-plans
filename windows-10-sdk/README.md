# windows-10-sdk

The Windows 10 SDK for Windows 10, version 1809 (servicing release 10.0.17763.132) provides the latest headers, libraries, metadata, and tools for building Windows 10 apps.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package


## Usage

This package is typically used as a build dependency for native application projects along with `core/visual-build-tools-2017`. Simply add`core/windows-sdk` to your build deps:

```
$pkg_build_deps=@(
    "core/visual-build-tools-2017",
    "core/windows-10-sdk"
)
```

Now the appropriate libraries and include headers should be added to your build environment.
