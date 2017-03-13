$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="1.0.1"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/F/D/5/FD52A2F7-65B6-4912-AEDD-4015DF6D8D22/dotnet-1.1.1-sdk-win-x64.zip"
$pkg_shasum="e729afcf3cc69f17ec7968468b399c843b8b8327523e62c03450e4653115cf76"
$pkg_filename="dotnet-1.1.1-sdk-win-x64.zip"
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
