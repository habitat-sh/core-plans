$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="3.1.14"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/31b707c9-0484-48b5-b248-7f22946f88b5/a998787f1b26a7f742c84cbec7f145d2/dotnet-runtime-$pkg_version-win-x86.zip"
$pkg_shasum="aaca27f71c35cea5585e3b4ef521d8ef9f7b505a26c8979564c4cb77886fbfa2"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
