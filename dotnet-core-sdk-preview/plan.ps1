$pkg_name="dotnet-core-sdk-preview"
$pkg_origin="core"
$pkg_version="2.0.0-preview2-006497"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac. LTS release channel."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/F/A/A/FAAE9280-F410-458E-8819-279C5A68EDCF/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="c9b0205f24d310204dde39e80b996f98b6d546ad4507723cceb2578a208e507f"
$pkg_filename="dotnet-runtime-$pkg_version-01-win-x64.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
