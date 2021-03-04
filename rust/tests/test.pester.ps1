param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/rust" {
    Context "rustc" {
        It "returns --version that matches the plan" {
            $OutputVariable = (hab pkg exec $PackageIdentifier rustc -- --version | Out-String).split(' ')[1]
            "$OutputVariable" | Should -BeExactly "$PackageVersion"
        }
    }
}
