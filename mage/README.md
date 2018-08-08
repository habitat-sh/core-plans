# Mage

Mage is a make/rake-like build tool using Go. You write plain-old go functions, and Mage automatically uses them as Makefile-like runnable targets.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Binary Package

## Usage

Mage can be installed/used as a standalone binary:

```
hab pkg install core/mage
$(hab pkg path core/mage)/bin/mage

# or binlink

hab pkg install core/mage
hab pkg binlink core/mage
mage
```

Alternatively, it can be used in your pacakges build dependencies for running Magefiles.

```
pkg_build_deps=(core/mage)

do_build() {
  ...
  mage
  ...
}
```
