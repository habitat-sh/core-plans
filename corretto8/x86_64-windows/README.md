# Corretto 8

Amazon Corretto is a no-cost, multi-platform, production-ready distribution of the Open Java Development Kit (OpenJDK). The implementation is licensed under the GNU General Public License version 2 with a Classpath exception.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install:
```
hab pkg install core/corretto8
```

Execute:
```
hab pkg exec core/corretto8 java -h
```

Add to a plan:
```
pkg_deps=(
  core/corretto8
)
```
