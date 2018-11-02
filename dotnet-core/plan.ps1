$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="2.1.5"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/ce443d89-75f1-4122-aaa8-c094a9017b4a/255b06ace4207a8ee923758160ed01c3/dotnet-runtime-${pkg_version}-win-x64.zip"
$pkg_shasum="bfee610814720072bf67d3cc5738345a83ebb517add66f4fdaea280f417e91ed"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
