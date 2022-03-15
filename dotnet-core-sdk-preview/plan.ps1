$pkg_name="dotnet-core-sdk-preview"
$pkg_origin="core"
$pkg_version="2.1.300-preview2-008533"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac. LTS release channel."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/3/7/C/37C0D2E3-2056-4F9A-A67C-14DEFBD70F06/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="e09075337e2e7e0ddab2091f8bcd82d71434401aab5e94705652483eb64abd5a"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
