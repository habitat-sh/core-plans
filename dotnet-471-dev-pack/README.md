# Habitat package: dotnet471

## Description

This package is for the .NET 4.7.1 framework developer pack from microsoft. It provides 4.7.1 reference assemblies as well as the SDK needed to support building .NET 4.7.1 applications

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Binary

## Usage

Add core/dotnet471 to pkg_build_deps then leverage nuget and msbuild to build and deploy your application. For an example see mwrock's asp full framework MVC blog post: https://www.habitat.sh/blog/2017/08/Habitat-plans-for-net-full-iis-apps/

# Testing dotnet-471-dev-pack on Windows

**Note**: before proceeding, [Pester](https://github.com/pester/Pester/wiki/Installation-and-Update) must be installed on the testing system

## Build and Install the dotnet-471-dev-pack core plan

### Build

Open a powershell terminal at the root directory of the core-plans repo and then build the package:

```powershell
# build dotnet-471-dev-pack from its own directory
hab pkg build .\dotnet-471-dev-pack
```

### Install and Test

In a different terminal and also at the same core-plans directory, open a dockerised habitat studio with ``hab studio enter -D`` and then install the recently built dotnet-471-dev-pack core plan

```powershell
# Load the habitat build variables
. .\results\last_build.ps1

# install the habitat package
hab pkg install .\results\$pkg_artifact

# trigger the pester tests
$Arguments = @{ PackageIdentifier = "$pkg_ident" }
& .\dotnet-471-dev-pack\test\test.ps1 @Arguments
```

Sample output:

```powershell
[HAB-STUDIO] Habitat:\src> $Arguments = @{ PackageIdentifier = "$pkg_ident" }
[HAB-STUDIO] Habitat:\src> & .\dotnet-471-dev-pack\test\test.ps1 @Arguments
Executing all tests in 'C:\src\dotnet-471-dev-pack\test/test.pester.ps1'

Executing script C:\src\dotnet-471-dev-pack\test/test.pester.ps1

  Describing The NETFXSDK installation of pkg_ident [core/dotnet-471-dev-pack/4.7.1/20190501111308] when

    Context is the SDK version 4.7
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7/Include/um' directory 3ms
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7/Lib/um/x64' directory 3ms
      [+] has the 'Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX 4.7 Tools/x64' directory 8ms

    Context is the SDK version 4.7.1
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7.1/Include/um' directory 3ms
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7.1/Lib/um/x64' directory 4ms
      [+] has the 'Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX 4.7.1 Tools/x64' directory 3ms
Tests completed in 187ms
Tests Passed: 6, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0
[HAB-STUDIO] Habitat:\src>

```