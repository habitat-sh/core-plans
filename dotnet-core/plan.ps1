$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="2.2.0"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/62711024-fa98-4919-9fe0-466744b20941/4cdef0431350a441b45e11784f657b09/dotnet-runtime-${pkg_version}-win-x64.zip"
$pkg_shasum="191c08b9d8de65b5203fbd61d7e82a332225727628d0d6ca3b7a25afac819f62"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
