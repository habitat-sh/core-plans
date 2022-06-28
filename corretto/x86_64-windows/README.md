# Corretto

Amazon Corretto is a no-cost, multi-platform, production-ready distribution of
the Open Java Development Kit (OpenJDK). The implementation is licensed under
the GNU General Public License version 2 with a Classpath exception.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install:
```
hab pkg install core/corretto
```

Execute:
```
hab pkg exec core/corretto java -h
```

Add to a plan:
```
pkg_deps=(
  core/corretto
)
```
## Note

Unlike Amazon Corretto 8, the JRE is not included in this release.
```
