$pkg_name="nuget"
$pkg_origin="core"
$pkg_version="4.9.4"
$pkg_license=('Apache-2.0')
$pkg_upstream_url="https://dist.nuget.org/index.html"
$pkg_description="NuGet is the package manager for the Microsoft development platform including .NET."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dist.nuget.org/win-x86-commandline/v${pkg_version}/nuget.exe"
$pkg_shasum="cb139d855d06d07e7da892e8558fe16dcaa65cb381175c506f5ed0a759eaf8f6"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack { }

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/nuget.exe" "$pkg_prefix/bin" -Force
}
