$pkg_name="dotnet-5-runtime"
$pkg_origin="core"
$pkg_version="5.0.6"
$pkg_license=('MIT')
$pkg_upstream_url="https://dotnet.microsoft.com/"
$pkg_description=".NET is a free, cross-platform, open-source developer platform for building many different types of applications."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dotnetcli.azureedge.net/dotnet/Runtime/$pkg_version/dotnet-runtime-$pkg_version-win-x64.zip"
$pkg_shasum=""62464751fb0744e85acca14f14304ed21f0ab11b38ba16e43072cb3fc6ca16f7
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
