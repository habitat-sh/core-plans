# iis-aspnet35

This package enables the `IIS-ASPNET` Windows feature which enables IIS to host ASP.NET 3.5 application pools.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Usage

Add core/iis-aspnet35 to your dependencies. If the `IIS-ASPNET` feature has not been enabled, the `install` hook will enable it and all dependent features.

**Note:** Until the `INSTALL_HOOK` feature is no longer experimental, this package requires that the `HAB_FEAT_INSTALL_HOOK` environment variable be set in order for the `install` hook to run.
