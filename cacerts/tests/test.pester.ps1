param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "core/cacerts" {
    Context "installation" {
        It "has a valid cert.pem that contains a valid Mozilla certificate" {
            Get-Content "C:/hab/pkgs/$PackageIdentifier/ssl/cert.pem" | Out-String | Should -Match "Certificate data from Mozilla"
        }
    }
}
