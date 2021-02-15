$pkg_name="dotnet-5-runtime"
$pkg_origin="core"
$pkg_version="5.0.0"
$pkg_license=('MIT')
$pkg_upstream_url="https://dotnet.microsoft.com/"
$pkg_description=".NET is a free, cross-platform, open-source developer platform for building many different types of applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.azureedge.net/dotnet/Runtime/$pkg_version/dotnet-runtime-$pkg_version-win-x64.zip"
$pkg_shasum="8c38f4bf443bcccce00143c5aee7ca357502fd4a2515da2ce1a0295136978b14"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
