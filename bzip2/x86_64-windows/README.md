# bzip2

[bzip2][1] is a freely available, patent free (see below), high-quality data compressor.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

To use this plan, include it in your `pkg_build_deps` or `pkg_deps`, for example:

```
pkg_build_deps=(core/bzip2)
```

or use it directly:

```
hab pkg install core/bzip2 --binlink
bzip2
```

[1]: http://www.bzip.org/
