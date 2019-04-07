$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="2.2.3"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/25d53223-179f-46db-b99d-5d433c93a021/dd1f391be09111440b3afe38d22bc15d/dotnet-runtime-${pkg_version}-win-x64.zip"
$pkg_shasum="3a867c60d5390c5d7c581c61c0545b472254f4d29b85f7adc0336b4cb28f7fd4"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
