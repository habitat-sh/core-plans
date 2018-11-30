$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="2.1.500"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/2a508a9d-91e8-4126-904c-f7a515f8a33b/24ff5fe2610ce1ce76370ed053b14094/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="113575b3126791ee4d77e0fb36d9407bd62270101c8351f8da0937b660cb7cd8"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
  mkdir dotnet-new
  Push-Location dotnet-new
  ../dotnet.exe new web
  if(!(Test-Path "program.cs")) {
    Pop-Location
    Write-Error "dotnet app was not generated"
  }
  Pop-Location
  Remove-Item -Recurse -Force dotnet-new
}
