# re2c

re2c is a lexer generator for C/C++.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

If your plan/package requires re2c, you can include it as a build/runtime dependency as necessary:

In your plan:

```
pkg_build_deps=(
  core/re2c
)
```

This will make `re2c` available on your path, and accessible for your builds.

If you want to run re2c directly, install the package, and run:

```
hab pkg install core/re2c
hab pkg exec core/re2c re2c
```

On Linux systems, you can binlink instead, and then simply run the command:

```
hab pkg install --binlink core/re2c
re2c
```
