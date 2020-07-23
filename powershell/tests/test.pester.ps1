param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "The pwsh bin" {
    $expectedVersion = $PackageIdentifier.split("/")[2]

    It "pwsh matches version ${expectedVersion}" {
        $output = hab pkg exec "${PackageIdentifier}" pwsh --version
        $actualVersion = $output.split(" ")[1]
        $actualVersion | Should -BeExactly $expectedVersion
    }
}
