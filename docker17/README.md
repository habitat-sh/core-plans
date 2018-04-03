# docker 17

The Docker 17 Engine

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

This plan tracks Docker 17.x versions.

The docker plan _only_ provides users access to the standalone [docker binaries](https://docs.docker.com/engine/installation/binaries/). It is provided with the intention that any user's who need to run docker will write their own plan that depends on this package and provide their own runtime management.

Docker is a complex piece of software with multiple ways in which it can be configured to run. As such we provide this package to enable you to wrap and automate your preferred deployment style.
