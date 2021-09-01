param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/cmake" {
    Context "cmake" {
        $OutputVariable = (hab pkg exec $PackageIdentifier cmake -- --version | Out-String)
        $OutputVariable -match  "(?<=cmake version )([0-9\.]*)"
        It "returns --version that matches the plan" {
            $matches[0] | Should -BeExactly "$PackageVersion"
        }
    }
}
