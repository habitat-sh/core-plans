# 7zip

7-Zip is a file archiver with a high compression ratio.

## Maintainers

The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the package and execute 7zip.

On windows, `binlink` is not supported, so you can execute directly from the package:

```
hab pkg install core/7zip
hab pkg exec core/7zip 7z --help
```

On Linux you can do the same, or binlink and use the command directly:

```
hab pkg install core/7zip --binlink
7z --help
```

## Tests

### Windows

To run tests of an already built package in a new studio instance:

```powershell
hab studio enter
hab pkg install core/7zip/16.04/20190513101258
$Arguments = @{ PackageIdentifier =  "core/7zip/16.04/20190513101258" }
Install-Module -Name Pester -Force
.\7zip\tests\test.ps1 @Arguments
```

Sample output:

```powershell
[HAB-STUDIO] Habitat:\src> .\7zip\tests\test.ps1 @Arguments
Executing all tests in 'C:\src\7zip\tests/test.pester.ps1'

Executing script C:\src\7zip\tests/test.pester.ps1

  Describing The 7z bin

    Context 7z invoked without options
      [+] Runs and exits successfully 295ms
      [+] Mentions the expected version number on stdout 215ms
Tests completed in 1.13s
Tests Passed: 2, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0
```
