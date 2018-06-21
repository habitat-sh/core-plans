# Habitat package: optipng

OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information.

## Maintainers

The Habitat Maintainers (humans@habitat.sh).

## Type of package

Binary package. Ships the optipng binary only.

## Usage

You can install this to use the binary, or add it as a dependency for your plans.

As a dependency, place the following in your `plan.sh`:

```
pkg_deps=(
  core/optipng
)
```

Or to just use the binary:

```
hab pkg install --binlink core/optipng
optipng myfile.png
```
