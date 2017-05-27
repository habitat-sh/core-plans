$pkg_name="dotnet-core-lts"
$pkg_origin="core"
$pkg_version="1.0.5"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac. LTS release channel."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/$pkg_version/dotnet-win-x64.$pkg_version.zip"
$pkg_shasum="c930b72b6510b916423ab93a6a4c19b334b9c2215ec2abbe446e4e2defc76177"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
