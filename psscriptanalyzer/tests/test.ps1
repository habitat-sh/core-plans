# Ensure package ident has been passed
param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Usage: test.ps1 [test_pgk_ident] e.g. test.ps1 core/7zip/16.04/20190513101258")
)

# Ensure Pester is installed
if (-Not (Get-Module -ListAvailable -Name Pester)) {
    hab pkg install core/pester
    Import-Module "$(hab pkg path core/pester)/module/Pester.psd1"
}

# Install the package
hab pkg install $PackageIdentifier

# Test the package
$__dir = (Get-Item $PSScriptRoot)
$test_result = Invoke-Pester -PassThru -Script @{
    Path       = "$__dir/test.pester.ps1";
    Parameters = @{PackageIdentifier = $PackageIdentifier }
}
Exit $test_result.FailedCount
