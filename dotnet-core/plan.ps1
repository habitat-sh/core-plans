$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="2.1.6"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/3f6b6def-4e9a-4405-b21f-89f77d1605c4/52be50baa0e9bfa118fe6de80be89ab6/dotnet-runtime-${pkg_version}-win-x64.zip"
$pkg_shasum="f528261c7532847025d19dafd11d543cefc4860209feb0d7ea5356518a288548"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
