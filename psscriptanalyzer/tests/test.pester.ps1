param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "The PSScriptAnalyzer version" {
    $expectedVersion = $PackageIdentifier.split("/")[2]

    It "matches given ident version ${expectedVersion}" {
        Import-Module "$(hab pkg path core/psscriptanalyzer)/module/PSScriptAnalyzer.psd1"
        (Get-Command Invoke-ScriptAnalyzer).Version.ToString() | Should -Be $expectedVersion
    }
}
