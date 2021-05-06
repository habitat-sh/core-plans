$pkg_name="dotnet-5-sdk"
$pkg_origin="core"
$pkg_version="5.0.100"
$pkg_license=('MIT')
$pkg_upstream_url="https://dotnet.microsoft.com/"
$pkg_description=".NET is a free, cross-platform, open-source developer platform for building many different types of applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.azureedge.net/dotnet/Sdk/$pkg_version/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="296c89fbfdfedb652e314342e0de069ff392db1a4b0367a2daa9554cf50c1dec"
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
