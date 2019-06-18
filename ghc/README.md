# ghc

The Glasgow Haskell Compiler

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Build

ghc takes a very long time to build. On a typical 4 core, 4GB memory Docker based Habitat studio, the build can take 2 hours!

Habitat Builder is currently unable to handle builds that take over 1 hour to build, like ghc. See: https://github.com/habitat-sh/core-plans/issues/2065

For this reason, automatic rebuilds for ghc are disabled in Habitat Builder.

## Usage

*TODO: Add instructions for usage*
