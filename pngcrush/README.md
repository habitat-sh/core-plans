# pngcrush

Pngcrush is an optimizer for PNG (Portable Network Graphics) files.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install this package to run the binary, or include it as a dependency of your own plan to allow it to be called from some other process.

```
hab pkg install --binlink core/pngcrush
pngcrush --help
```

or

```
# in myplan/plan.sh
pkg_deps=(
  core/pngcrush
)
```
