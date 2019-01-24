# dotnet-472-runtime

This package installs the .Net full framework version 4.7.2 if version 4.7.2 or greater is not already installed.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Usage

Add core/dotnet-472-runtime to your dependencies. If the .Net full framework version 4.7.2 or greater is not installed, the `install` hook will install it.

Be aware that the hook will fail if the installation completes with a non `0` exit code. This can happen if the installation requires a reboot. If any other .Net v4 applications are running on the machine during the installation, then the machine must be rebooted in order for the installation to complete.

**Note:** Until the `INSTALL_HOOK` feature is no longer experimental, this package requires that the `HAB_FEAT_INSTALL_HOOK` environment variable be set in order for the `install` hook to run.
