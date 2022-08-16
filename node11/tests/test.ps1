param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Usage: test.ps1 [test_pgk_ident] e.g. test.ps1 core/7zip/16.04/20190513101258")
)

if (-Not (Get-Module -ListAvailable -Name Pester)) {
    Install-Module -Name Pester -Force
}

hab pkg install $PackageIdentifier

$__dir=(Get-Item $PSScriptRoot)
Invoke-Pester -EnableExit -Script @{
    Path       = "$__dir/test.pester.ps1";
    Parameters = @{PackageIdentifier =$PackageIdentifier}
}
