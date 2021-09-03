$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="3.1.408"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/2436ee79-1fbc-4f6a-94b4-e6fe6aafde13/abbd1ab0ca754adce35a6fd83f85dd2f/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="ca60e96b0f68e84424d4c76b3864abe9a4e675ee9fddca09fdf2989a5fadc0b4"
$pkg_bin_dirs=@("bin")

function Invoke-SetupEnvironment {
    Set-RuntimeEnv -IsPath "MSBuildSDKsPath" "$pkg_prefix\bin\sdk\$pkg_version\Sdks"
}

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
