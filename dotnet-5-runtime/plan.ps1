$pkg_name="dotnet-5-runtime"
$pkg_origin="core"
$pkg_version="5.0.15"
$pkg_license=('MIT')
$pkg_upstream_url="https://dotnet.microsoft.com/"
$pkg_description=".NET is a free, cross-platform, open-source developer platform for building many different types of applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.azureedge.net/dotnet/Runtime/$pkg_version/dotnet-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="e39c55364dc59af91828c80a08b511112a02d8341c6b4b2cda9d0630afa707bd"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
