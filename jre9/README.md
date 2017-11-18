# Java JRE9

## Description

This package contains the Java JRE 9 environment required to run java applications.

Include this as a dependency in your own plan, so you can run your jars.

Couple it with the `core/jdk9` package for building your app (if necessary)

## Usage

Your `plan.sh` dependencies will look similar to this:

```
pkg_deps=(
  core/jre9
)
pkg_build_deps=(
  core/jdk9
)
```

Then, from your own `plan.sh` run hook, you can `exec java ...` to run your application.
