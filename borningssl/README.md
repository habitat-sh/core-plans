# boringssl

BoringSSL is a fork of OpenSSL that is designed to meet Google's needs.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Library package

## Usage

This is a library usually used at build time, thus you should use it like so in your plans:

```
pkg_build_deps=(
    core/boringssl
)
```
