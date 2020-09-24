param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "core/openssl-fips" {
    Context "openssl-fips" {
        Write-Output "a_byte_character" > testfile
        $OutputVariable = (hab pkg exec $PackageIdentifier fips_standalone_sha1 testfile | Out-String).Trim().Split()
        It "returns correct encoded string" {
            $OutputVariable[1] | Should -BeExactly "2f0c57ed208ff153f9216856f49d27b9a56e4016"
        }
    }
}
