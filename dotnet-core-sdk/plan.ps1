$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="2.2.401"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/4de548ef-9b51-4b1f-ae3a-60ebd6a6f2b5/01fce24fe286e7475fdbecc60f1daee5/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="adff0b27798ce6233ee8952ee83b02d9f197214fab77c9ee311b1ce904f52bb7"
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
