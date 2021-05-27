param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

$PackageVersion = $PackageIdentifier.split('/')[2]
Describe "core/openssl" {
    Context "openssl" {
        $OutputVariable = (hab pkg exec $PackageIdentifier openssl -- version | Out-String).Trim()
        $OutputVariable -match "(?<=^OpenSSL )([^ ]*)"
        It "version matches $PackageVersion" {
            $matches[0] | Should -BeExactly "$PackageVersion"
        }

        $OutputVariable = ("a_byte_character" | hab pkg exec $PackageIdentifier openssl -- enc -base64| Out-String).Trim()
        It "returns correct encoded string" {
            "$OutputVariable" | Should -BeExactly "YV9ieXRlX2NoYXJhY3Rlcg0K"
        }
    }
}
