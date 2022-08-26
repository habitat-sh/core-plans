# alsa-lib

This package provides the ALSA library.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Typically this is a runtime dependency that can be added to your
plan.sh:

    pkg_deps=(core/alsa-lib)

## Testing

Run the tests after building the package like so:

```bash
hab studio build alsa-lib
source results/last_build.env
hab studio run "./alsa-lib/tests/test.sh $pkg_ident"
```

Sample output:

```bash
✓ Installed core/alsa-lib/1.1.8/20190530132818
★ Install of core/alsa-lib/1.1.8/20190530132818 complete with 1 new packages installed.
1..4
ok 1 package directory for package ident core/alsa-lib/1.1.8/20190530132818 exists
ok 2 libraries are dynamically linked
ok 3 aserver is dynamically linked
ok 4 aserver help command works
```
