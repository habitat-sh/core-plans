$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="1.0.0-preview3-003930"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$pkg_version/dotnet-dev-win-x64.$pkg_version.zip"
$pkg_shasum="b52c46aa933a6f7ccd60f3d6e88cf0b7c6479a3dba395be276ea743d71b04a13"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item . "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
  mkdir dotnet-new
  pushd dotnet-new
  ../dotnet.exe new
  popd
  Remove-Item -Recurse -Force dotnet-new
}
