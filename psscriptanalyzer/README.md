# PSScriptAnalyzer

PSScriptAnalyzer is the ubiquitous linting framework for PowerShell.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

A Binary package containing a Powershell Module

## Usage

Import the PSScriptAnalyzer module:

```
# From a powershell prompt
Import-Module "$(hab pkg path core/psscriptanalyzer)\module\PSScriptAnalyzer.psd1"
# From a plan.ps1
Import-Module "$(Get-HabPackagePath psscriptanalyzer)\module\PSScriptAnalyzer.psd1"
```

Now you can call PSScriptAnalyzer functions like `Invoke-ScriptAnalyzer`.
