# coredns

CoreDNS is a DNS server/forwarder, written in Go, that chains plugins.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

The CoreDNS plan is absoilutely minimal. It is best utilized as a dependency for your own plans that construct a more situationally suitable `CoreFile` for CoreDNS configuration.

Example:

```sh
pkg_name=mydns
pkg_core=acme
...
pkg_deps=(
  core/coredns
)
```

## Topologies

This plan is currently only designed for standalone topology.

## Update Strategies

Any update strategy will work, but at-once is sufficient for a standalone deployment.
