# ghc710-bootstrap

The Glasgow Haskell Compiler - Binary Bootstrap

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

This package is meant purely for bootstrapping GHC into the habitat ecosystems
and should not be used for compiling projects.

A new version of GHC has to be bootstrapped via a prexisting binary whenever
the [ClosureFlags.c](https://github.com/ghc/ghc/blob/master/rts/ClosureFlags.c)
change, as previous versions of GHC will not be able to build the new version.
