$pkg_name="dotnet-10-sdk"
$pkg_origin="core"
$pkg_version="10.0.300"
$pkg_license=('MIT')
$pkg_upstream_url="https://dotnet.microsoft.com/"
$pkg_description=".NET is a free, cross-platform, open-source developer platform for building many different types of applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://builds.dotnet.microsoft.com/dotnet/Sdk/$pkg_version/dotnet-sdk-$pkg_version-win-x64.zip"
$pkg_shasum="E85F941286C311AD4D61C620291509F3B9B75EF17902E148B0DF5A49D909B5F4"
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
