# psscriptanalyzer

PSScriptAnalyzer is a static code checker for Windows PowerShell modules and scripts. PSScriptAnalyzer checks the quality of Windows PowerShell code by running a set of rules. The rules are based on PowerShell best practices identified by PowerShell Team and the community. It generates DiagnosticResults (errors and warnings) to inform users about potential code defects and suggests possible solutions for improvements.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

A Binary package containing a Powershell Module

## Usage

Import the PSScriptAnalyzer module:

```
# From a powershell prompt
Import-Module "$(hab pkg path core/psscriptanalyzer)\module\psscriptanalyzer.psd1"
# From a plan.ps1
Import-Module "$(Get-HabPackagePath psscriptanalyzer)\module\psscriptanalyzer.psd1"
```

See https://github.com/PowerShell/PSScriptAnalyzer#usage for guidance on invoking and configuring PSScriptAnalyzer.
