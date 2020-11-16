param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "dotnet 5 runtime" {
    It "Has the correct version" {
        $expected_version = $PackageIdentifier.split("/")[2]
        $output = hab pkg exec $PackageIdentifier dotnet --info
        $output | Out-String | Should -Match "Version: $expected_version"
    }
}
