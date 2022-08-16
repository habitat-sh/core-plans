param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/git" {
    Context "git" {
        $OutputVariable = (hab pkg exec $PackageIdentifier git -- --version | Out-String).split(' ')[2]
        It "returns --version that matches the plan" {
            "$OutputVariable" | Should -Match "$PackageVersion"
        }
    }
}
