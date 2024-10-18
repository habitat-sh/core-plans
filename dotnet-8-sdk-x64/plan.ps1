$pkg_name="dotnet-8-sdk-x64"
$pkg_origin="core"
$pkg_version="8.0.400"
$pkg_license=('MIT')
$pkg_upstream_url="https://dotnet.microsoft.com/"
$pkg_description=".NET is a free, cross-platform, open-source developer platform for building many different types of applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/cfccc24b-46eb-4515-b696-161ec8652b39/9fb1edaba0f12a56446fa6716a1789ca/dotnet-sdk-$pkg_version-win-x64.zip"
# https://download.visualstudio.microsoft.com/download/pr/cfccc24b-46eb-4515-b696-161ec8652b39/9fb1edaba0f12a56446fa6716a1789ca/dotnet-sdk-8.0.400-win-x64.zip
$pkg_shasum="9B73E9F42DDED03C6FFE5564EA6CDCF69BB42156D94BDDCB85EF2380EBB7FC5F"
$pkg_bin_dirs=@("bin")

function Invoke-SetupEnvironment {
    Set-RuntimeEnv -IsPath "MSBuildSDKsPath" "$pkg_prefix\sdk\$pkg_version\Sdks"
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
