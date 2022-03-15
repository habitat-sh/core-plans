$pkg_name="dotnet-core-sdk"
$pkg_origin="core"
$pkg_version="3.1.417"
$pkg_license=('MIT')
$pkg_upstream_url="https://www.microsoft.com/net/core"
$pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/7c6cd67f-61d2-4b4e-bf19-556043769544/cfa8364fb2b22b4602ee14b60b8c8ca1/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="8d7b82eb50ed5034ddc9dcc22ec254918573b07f7381fb647c84641d045b08ac"
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
