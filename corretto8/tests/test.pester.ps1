param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "The java bin" {
    Context "java invoked without options" {
        It "Runs and exits successfully" {
            hab pkg exec $PackageIdentifier java -version
            $? | Should be $true
        }
        It "Mentions the expected version number on stdout" {
            $expected_version = $PackageIdentifier.split("/")[2]
            $output = hab pkg exec $PackageIdentifier java -version 2>&1
            $output | Out-String | Should -Match "${expected_version}"
        }
    }
}
