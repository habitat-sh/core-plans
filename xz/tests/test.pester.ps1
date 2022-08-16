param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/xz" {
    Context "xz" {
        $OutputVariable = ((hab pkg exec $PackageIdentifier xz --version)[0] | Out-String).Trim()
        It "returns --version that matches the plan" {
            "$OutputVariable"  | Should -BeExactly "xz (XZ Utils) $PackageVersion"
        }
    }
}
