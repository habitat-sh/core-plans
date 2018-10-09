$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="2.1.403"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/28820b2a-0aec-4c24-a271-a14bcb3e2686/5e0ad8ae32f1497e8d0cace2447b9e01/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="6837e66804c2a782212e68546d19711718c93ee28a62807ab6d381a55583ab26"
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
