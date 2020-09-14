param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "core/cacerts" {
    Context "installation" {
        It "has a valid cert.pem that contains a valid Mozilla certificate" {
            Get-Content "$(hab pkg path $PackageIdentifier)/ssl/cert.pem" | Out-String | Should -Match "Certificate data from Mozilla"
        }
    }
}
