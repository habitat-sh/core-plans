$pkg_name="dotnet-9-sdk"
$pkg_origin="core"
$pkg_version="9.0.101"
$pkg_license=('MIT')
$pkg_upstream_url="https://dotnet.microsoft.com/"
$pkg_description=".NET is a free, cross-platform, open-source developer platform for building many different types of applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://builds.dotnet.microsoft.com/dotnet/Sdk/9.0.101/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="0CCCD1758FAFE95930D6F783EF60EFAC4891BC4574791F9CEEE04ABC876CB0D6"
$pkg_bin_dirs=@("bin")

function Invoke-SetupEnvironment {
    Set-RuntimeEnv -IsPath "MSBuildSDKsPath" "$pkg_prefix\bin\sdk\$pkg_version\Sdks"
}

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
    $env:MSBuildSDKsPath = (Resolve-Path "sdk\$pkg_version\Sdks").Path
    mkdir dotnet-new
    Push-Location dotnet-new
    ../dotnet.exe new web
    if(!(Test-Path "program.cs")) {
        Pop-Location
        Write-Error "dotnet app was not generated"
    }
    ../dotnet.exe restore
    if($LASTEXITCODE -ne 0) { Write-Error "dotnet restore failed!" }
    Pop-Location
    Remove-Item -Recurse -Force dotnet-new
}
