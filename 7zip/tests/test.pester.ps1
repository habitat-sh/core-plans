param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "The 7z bin" {
    Context "7z invoked without options" {
        It "Runs and exits successfully" {
            hab pkg exec $PackageIdentifier 7z
            $? | Should be $true
        }
        It "Mentions the expected version number on stdout" {
            $expected_version = $PackageIdentifier.split("/")[2]
            $output = hab pkg exec $PackageIdentifier 7z
            $output | Out-String | Should -Match ".*7-Zip \[64\] ${expected_version}.*"
        }
    }
}
