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

### Build and Install

Open a powershell terminal at the root directory of the core-plans repo, build and install the package:

```powershell
hab studio run -D "hab pkg build dotnet-471-dev-pack"
. .\results\last_build.ps1
hab studio run -D "hab pkg install results/$pkg_artifact"
```

### Test

In a different terminal, test the package:

```powershell
. .\results\last_build.ps1
hab studio run -D "& dotnet-471-dev-pack/tests/test.ps1 $pkg_ident"
```

Sample output:

```powershell
PS C:\Users\azureuser\Documents\habitat\core-plans> hab studio run -D "& dotnet-471-dev-pack/tests/test.ps1 $pkg_ident"
   hab-studio: Creating Studio at C:\
» Importing origin key from standard input
★ Imported public origin key core-20190508125251.
» Importing origin key from standard input
★ Imported secret origin key core-20190508125251.
   hab-studio: Running '& dotnet-471-dev-pack/tests/test.ps1 core/dotnet-471-dev-pack/4.7.1/20190508130615' in Studio at
 C:\
» Installing core/pester
☁ Determining latest version of core/pester in the 'stable' channel
☛ Verifying core/pester/4.8.1/20190517153523
✓ Installed core/pester/4.8.1/20190517153523
★ Install of core/pester/4.8.1/20190517153523 complete with 1 new packages installed.
» Installing core/dotnet-471-dev-pack/4.7.1/20190508130615
☛ Verifying core/dotnet-471-dev-pack/4.7.1/20190508130615
✓ Installed core/dotnet-471-dev-pack/4.7.1/20190508130615
★ Install of core/dotnet-471-dev-pack/4.7.1/20190508130615 complete with 1 new packages installed.
Executing all tests in 'C:\src\dotnet-471-dev-pack\tests/test.pester.ps1'

Executing script C:\src\dotnet-471-dev-pack\tests/test.pester.ps1

  Describing The NETFXSDK installation of pkg_ident [core/dotnet-471-dev-pack/4.7.1/20190508130615] when

    Context is the SDK version 4.7
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7/Include/um' directory 65ms
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7/Lib/um/x64' directory 4ms
      [+] has the 'Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX 4.7 Tools/x64' directory 37ms

    Context is the SDK version 4.7.1
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7.1/Include/um' directory 3ms
      [+] has the 'Program Files/Windows Kits/NETFXSDK/4.7.1/Lib/um/x64' directory 3ms
      [+] has the 'Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX 4.7.1 Tools/x64' directory 3ms
Tests completed in 803ms
Tests Passed: 6, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0
```
