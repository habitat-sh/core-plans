$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="2.0.6"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/8/D/A/8DA04DA7-565B-4372-BBCE-D44C7809A467/dotnet-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="d10abca0c869e72fcb45fe75940b1f28aed5dbbb1d5b048737d71d732a7b6670"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
