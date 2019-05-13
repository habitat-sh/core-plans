#!/usr/bin/env pwsh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Validate Input Parameters and System Software
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
param (
    [Parameter(Mandatory=$true)]
    [string]$PackageIdentifier = ""
)

# validate pre-requisite software on test system
if (-Not (Get-Module -ListAvailable -Name Pester)) {
    $message = -join @(
        "Pester module must be installed before proceeding. "
        "Refer to the following URL to install Pester: "
        "https://github.com/pester/Pester/wiki/Installation-and-Update"
    )
    throw $message
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# test the package
$__dir=(Get-Item $PSScriptRoot)
Invoke-Pester -Script @{
    Path = "$__dir/test.pester.ps1";
    Parameters = @{PackageIdentifier=$PackageIdentifier}
}
