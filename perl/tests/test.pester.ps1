param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/perl" {
    Context "perl" {
        $OutputVariable = (hab pkg exec $PackageIdentifier perl --version | Out-String).split(' ')
        It "returns --version that matches the plan" {
            "$OutputVariable" | Should -BeExactly "$PackageVersion"
        }
    }
}
