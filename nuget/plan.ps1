$pkg_name="nuget"
$pkg_origin="core"
$pkg_version="4.1.0"
$pkg_license=('Apache-2.0')
$pkg_upstream_url="https://dist.nuget.org/index.html"
$pkg_description="NuGet is the package manager for the Microsoft development platform including .NET."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dist.nuget.org/win-x86-commandline/v${pkg_version}/nuget.exe"
$pkg_shasum="4c1de9b026e0c4ab087302ff75240885742c0faa62bd2554f913bbe1f6cb63a0"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/nuget.exe" "$pkg_prefix/bin" -Force
}
