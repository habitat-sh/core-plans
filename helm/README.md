# Helm

Builds the `helm` binary for a specific GitHub release.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Binary package

## Usage

This package is meant to be installed and optionally bin-linked using `hab pkg install core/helm --binlink`.

You can also use it as a `pkg_dep` if your application requires helm in lifecycle hooks.

For information on how to use `helm` itself, please consult the [official documentation](https://docs.helm.sh/using_helm/).
