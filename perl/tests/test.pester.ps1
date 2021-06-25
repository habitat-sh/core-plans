param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/perl" {
    Context "perl" {
        $OutputVariable = (hab pkg exec $PackageIdentifier perl.exe -- --version | Out-String)
        $OutputVariable -match "(?<=\(v)(.*?)(?=\) built for MSWin32)"
        It "returns --version that matches the plan"  {
            $matches[1] | Should -BeExactly "$PackageVersion"
        }
    }
}
