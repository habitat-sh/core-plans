param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "dsc-core" {
    Import-Module "$(hab pkg path $PackageIdentifier)\Modules\DscCore"
    Context "Apply Configuration with file resource" {
        It "creates the directory" {
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_with_resource
            "c:\test_directory" | Should exist
            $? | Should be $true
        }
    }
    Context "Apply Configuration without resource" {
        It "runs without error" {
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_without_resource
            $? | Should be $true
        }
    }
}
