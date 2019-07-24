$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="2.2.301"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/3c7fcb0b-52ee-40b2-853d-710c58883371/78bbdf5fcd85697e8e306c355d02d0b0/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="996a001ce2c415a24f21cee698ca1e2581ed5adced5b82763cb12326060feba0"
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
