param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "jq-static bin" {
    Context "jq-static" {
        It "has expected version" {
            $expected_version = $PackageIdentifier.split("/")[2]
            $output = hab pkg exec $PackageIdentifier jq --version
            $output | Out-String | Should -Match "jq-${expected_version}"
        }
    }
}
