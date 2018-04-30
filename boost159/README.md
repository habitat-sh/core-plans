# boost159

Boost provides free peer-reviewed portable C++ source libraries.

> Note: this package is required by `core/mysql` and `core/mysql-client` packages, you should use `core/boost` in your packages instead.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

This is a library usually used at build time, thus you should use it like so in your plans:

```
pkg_build_deps=(
    core/boost159
)
```
