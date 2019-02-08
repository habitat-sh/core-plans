# bats

Bash Automated Testing System

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper-packages)

## Usage

Install the package, or include it as a `pkg_dep`

```
hab pkg install core/bats
```

If you want to leverage the included libraries, add the following load statement to your tests.

```
load "$(hab pkg path core/bats)/lib/load.bash"
```
