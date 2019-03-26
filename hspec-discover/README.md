# hspec-discover

Automatically discover and run Hspec tests.

It is a useful convention to have one spec file for each source file. That way it is straightforward to find the
corresponding spec for a given piece of code. But it requires error prone, and neither challenging nor interesting
boiler plate code. So it should be automated. Hspec provides a solution for that. It makes creative use of GHC's support
for custom preprocessors.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Include `core/hspec-discover` in your `pkg_build_deps` in order to allow cabal to take advantage of it for automatic
hspec detection. If your haskell project is setup to use `hspec-discover`, a `cabal test` in your project's `do_check`
will automatically use it when appropriate.
