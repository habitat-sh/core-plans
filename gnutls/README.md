# gnutls

GnuTLS is a secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them

> Note that this package comes without DANE support, if you need it, feel free to open an issue at https://github.com/habitat-sh/core-plans/issues/new

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Typically this is a runtime dependency that can be added to your
plan.sh:

    pkg_deps=(core/gnutls)
