$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="3.1.100"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/28a2c4ff-6154-473b-bd51-c62c76171551/ea47eab2219f323596c039b3b679c3d6/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="abcd034b230365d9454459e271e118a851969d82516b1529ee0bfea07f7aae52"
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
