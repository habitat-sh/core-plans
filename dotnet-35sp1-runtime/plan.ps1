$pkg_name="dotnet-35sp1-runtime"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_source="https://dotnetbinaries.blob.core.windows.net/dockerassets/microsoft-windows-netfx3-ltsc2016.zip"
$pkg_description=".Net 3.5 Framework Servce Pack 1 Runtime"
$pkg_shasum="303866ec4f396fda465d5c8c563d44b4aa884c60dbe6b20d3ee755b604c4b8cb"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item "microsoft-windows-netfx3-ondemand-package.cab" "$pkg_prefix/bin"
}
