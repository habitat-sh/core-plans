# acbuild

A tool to build Application Container Images (ACI)

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

acbuild can be installed and run manually, or used as a dependency to your other plans.

Running manually:

```
hab pkg install --binlink core/acbuild
acbuild
```

Dependency usage:

```
pkg_build_deps=(core/acbuild)
```

## Testing

Run the BATS tests for this plan against a package ident like so:

```bash
hab pkg build acbuild
export results/last_build.env
hab studio run "./acbuild/tests/test.sh ${pkg_ident}"
```
