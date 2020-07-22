# pester

Pester is the ubiquitous test and mock framework for PowerShell.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

A Binary package containing a Powershell Module

## Usage

Import the pester module:

```
# From a powershell prompt
Import-Module "$(hab pkg path core/pester)\module\Pester.psd1"
# From a plan.ps1
Import-Module "$(Get-HabPackagePath pester)\module\Pester.psd1"
```

Now you can call pester functions like `Invoke-Pester`.
