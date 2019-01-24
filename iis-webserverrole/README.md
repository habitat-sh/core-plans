# iis-webserverrole

This package enables the `IIS-WebServerRole` Windows feature which enables IIS and some other IIS related features.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Usage

Add core/iis-webserverrole to your dependencies. If the `IIS-WebServerRole` feature has not been enabled, the `install` hook will enable it and all dependent features.

**Note:** Until the `INSTALL_HOOK` feature is no longer experimental, this package requires that the `HAB_FEAT_INSTALL_HOOK` environment variable be set in order for the `install` hook to run.
