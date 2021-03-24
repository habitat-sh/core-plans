param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Usage: test.ps1 [test_pgk_ident] e.g. test.ps1 core/7zip/16.04/20190513101258")
)

hab pkg install core/pester
Import-Module "$(hab pkg path core/pester)\module\pester.psd1" -Force

hab pkg install $PackageIdentifier

$__dir=(Get-Item $PSScriptRoot)
$test_result = Invoke-Pester -PassThru -Script @{
    Path       = "$__dir/test.pester.ps1";
    Parameters = @{PackageIdentifier =$PackageIdentifier}
}
Exit $test_result.FailedCount
