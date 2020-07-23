param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "The PSScriptAnalyzer version" {
    $origin = $PackageIdentifier.split("/")[0]
    $expectedVersion = $PackageIdentifier.split("/")[2]

    It "matches given ident version ${expectedVersion}" {
        Import-Module "$(hab pkg path $origin/psscriptanalyzer)/module/PSScriptAnalyzer.psd1"
        (Get-Command Invoke-ScriptAnalyzer).Version.ToString() | Should -Be $expectedVersion
    }
}
