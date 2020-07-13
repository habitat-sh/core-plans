# bc

bc is an arbitrary precision numeric processing language.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

```
hab pkg install --binlink core/bc
bc
```

Most often, bc is used as a dependency for other builds. It can be added to your `plan.sh` file:

```
pkg_build_deps=(core/bc)
```
