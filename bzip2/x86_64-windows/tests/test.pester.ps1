param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/bzip2" {
    Context "bzip2" {
        $OutputVariable = (hab pkg exec $pkg_ident bzip2 --help *>&1 | Out-String)
        $OutputVariable -match "(?<=Version )([^,]*)"
        It "returns version that matches the $PackageVersion" {
            $matches[0] | Should -BeExactly "$PackageVersion"
        }
    }
}
