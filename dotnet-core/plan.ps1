$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="3.1.23"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/d39730cf-7304-4710-bc6b-3efa34a7ccb2/f4b1c4cbf216894faf13a1ff2437acd8/dotnet-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="0f30455136a367fa1a87c27ba3bfba2394ca95712b6bf34cc9c64bfac437051e"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
