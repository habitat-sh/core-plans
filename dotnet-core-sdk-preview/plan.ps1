$pkg_name="dotnet-core-sdk-preview"
$pkg_origin="core"
$pkg_version="2.1.300-preview2-008530"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac. LTS release channel."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/3/7/C/37C0D2E3-2056-4F9A-A67C-14DEFBD70F06/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="9c9066e27d24fdc04c0845fbec57d7239d52b84732a090e6b69acacbf95878f3"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
