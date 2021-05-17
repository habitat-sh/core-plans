$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="3.1.14"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/d88fda36-5e76-447e-8ed4-c3bd4151663c/c2d1485326cdeaab2168ee1d0ced1e0a/dotnet-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="18abe372088ffe1e0b7479440254eff4901bfa262a35c4ed2971cdfe58159fc1"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
