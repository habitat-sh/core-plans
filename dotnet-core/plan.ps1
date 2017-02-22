$pkg_name="dotnet-core"
$pkg_origin="core"
$pkg_version="1.0.0-rc4-004771"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$pkg_version/dotnet-dev-win-x64.$pkg_version.zip"
$pkg_shasum="382ab6b7acb1d864b1c470d2c021c6176f124bb9497795098c0c030c95e9713a"
$pkg_filename="dotnet-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
  mkdir dotnet-new
  pushd dotnet-new
  ../dotnet.exe new
  popd
  Remove-Item -Recurse -Force dotnet-new
}
