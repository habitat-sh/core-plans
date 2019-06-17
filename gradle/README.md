# gradle

A powerful build system for the JVM

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the package:

```
hab pkg install core/gradle
```

Run the `gradle` command:

```
hab pkg exec core/gradle gradle --help
```

This package can also be included as a build dependency for your own plans:

```
...
pkg_build_deps=(core/gradle)
...
```

Doing so will make the `gradle` command available to your build process within your plan.
