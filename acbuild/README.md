# acbuild

A tool to build Application Container Images (ACI)

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

*TODO: Add instructions for usage*

## Testing

Run the BATS tests for this plan against a package ident like so:

```bash
hab pkg build acbuild
export results/last_build.env
hab studio run "./acbuild/tests/test.sh $pkg_ident"
```
