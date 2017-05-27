$pkg_name="dotnet-core-sdk-lts"
$pkg_origin="core"
$pkg_version="1.0.4"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac. LTS release channel."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$pkg_version/dotnet-dev-win-x64.$pkg_version.zip"
$pkg_shasum="82869baef9e010415583174b0b0be95a2cb326dfd36bb32ec270803a9c8196ec"
$pkg_filename="dotnet-dev-win-x64.$pkg_version.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
  mkdir dotnet-new
  Push-Location dotnet-new
  ../dotnet.exe new
  Pop-Location
  Remove-Item -Recurse -Force dotnet-new
}
