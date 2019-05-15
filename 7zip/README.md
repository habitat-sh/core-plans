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

### Linux

To run tests of an already built package in a new studio instance:

```bash
source results/last_build.env
hab studio run "./7zip/tests/test.sh $pkg_ident"
```

Sample output:

```bash
➜  core-plans git:(7zip) ✗ hab studio run "./7zip/tests/test.sh $pkg_ident"
   hab-studio: Importing 'core' secret origin key
» Importing origin key from standard input
★ Imported secret origin key core-20190311142149.
   hab-studio: Importing 'core' public origin key
» Importing origin key from standard input
★ Imported public origin key core-20190311142149.
   hab-studio: Exported: HAB_ORIGIN=core
» Installing core/bats
☁ Determining latest version of core/bats in the 'stable' channel
☛ Verifying core/bats/0.4.0/20190115015448
...
✓ Installed core/bats/0.4.0/20190115015448
★ Install of core/bats/0.4.0/20190115015448 complete with 1 new packages installed.
» Binlinking bats from core/bats/0.4.0/20190115015448 into /bin
★ Binlinked bats from core/bats/0.4.0/20190115015448 to /bin/bats
» Installing core/7zip/16.02/20190513161338
☛ Verifying core/7zip/16.02/20190513161338
...
✓ Installed core/7zip/16.02/20190513161338
★ Install of core/7zip/16.02/20190513161338 complete with 1 new packages installed.
1..5
ok 1 package directory for package ident core/7zip/16.02/20190513161338 exists
ok 2 7z exe runs
ok 3 7z exe output mentions expected version 16.02
ok 4 7za exe runs
ok 5 7za exe output mentions expected version 16.02
```

### Windows

To run tests of an already built package in a new studio instance:

```powershell
. .\results\last_build.ps1
hab studio run "& ./7zip/tests/test.ps1 $pkg_ident"
```

Sample output:

```powershell
PS C:\projects\core-plans> hab studio run "& ./7zip/tests/test.ps1 $pkg_ident"

Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      Job1            BackgroundJob   Running       True            localhost            Microsoft.PowerShell.M...
core/7zip/16.04/20190513101258
» Installing core/7zip/16.04/20190513101258
→ Using core/7zip/16.04/20190513101258
≡ Install of core/7zip/16.04/20190513101258 complete with 0 new packages installed.
Executing all tests in 'C:\projects\core-plans\7zip\tests/test.pester.ps1'

Executing script C:\projects\core-plans\7zip\tests/test.pester.ps1

  Describing The 7z bin

    Context 7z invoked without options
      [+] Runs and exits successfully 278ms
      [+] Mentions the expected version number on stdout 207ms
Tests completed in 1.03s
Tests Passed: 2, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0

```
