param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "node bin" {
    Context "node" {
        It "version matches" {
            $expected_version = $PackageIdentifier.split("/")[2]
            $output = hab pkg exec $PackageIdentifier node -- --version
            $output | Out-String | Should -Match "v${expected_version}"
        }
        It "help command" {
            hab pkg exec $PackageIdentifier node -- --help
            $? | Should be $true
        }
    }
}
