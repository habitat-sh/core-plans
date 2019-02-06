# dotnet-35sp1-runtime

This package enables the `NetFx3` Windows feature which installs the .Net 2.0 CLR and 3.5 Service Pack 1 runtime.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Usage

Add core/dotnet-35sp1-runtime to your dependencies. If the `NetFx3` feature has not been enabled, the `install` hook will enable it.

**Note:** Until the `INSTALL_HOOK` feature is no longer experimental, this package requires that the `HAB_FEAT_INSTALL_HOOK` environment variable be set in order for the `install` hook to run.
