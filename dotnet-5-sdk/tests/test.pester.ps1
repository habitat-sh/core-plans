param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "dotnet 5 sdk" {
    It "Has the correct version" {
        $expected_version = $PackageIdentifier.split("/")[2]
        hab pkg exec $PackageIdentifier dotnet -- --version | Should -Be $expected_version
    }
}
