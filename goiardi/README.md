# goiardi

A Chef server written in Go

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Binary package

## Usage

This plan should be used as a dependency of your own configuration plan, as it currently only supplies the binary.

However, you can use the binary directly:

```
hab pkg install core/goiardi
hab pkg exec core/goiardi goiardi --help
```

For details on how to use goiardi, please refer to the [documentation][docs].

[docs]: https://goiardi.readthedocs.io/
