# GoCD Server

[GoCD][gocd] is an open source tool which is used in software development to help teams and organizations automate the continuous delivery (CD) of software.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

```
hab pkg install core/gocd-server
hab svc load core/gocd-server
```

## Topologies

Currently only supports `standalone` topology.

## Update Strategies

Currently only supports `at-once` or no update strategy.

## Notes

[gocd]: https://www.gocd.org
