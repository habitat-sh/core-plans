# ccache

[ccache][1] is a compiler cache. It speeds up recompilation by caching previous compilations and detecting when the same compilation is being done again.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

To use this plan, include it in your `pkg_build_deps` or `pkg_deps`, for example:

```
pkg_build_deps=(core/ccache)
```

or use it directly:

```
hab pkg install core/ccache --binlink
ccache --help
```

[1]: https://ccache.samba.org/
