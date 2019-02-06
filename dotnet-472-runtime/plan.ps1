$pkg_name="dotnet-472-runtime"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Microsoft Software License")
$pkg_source="https://download.microsoft.com/download/6/E/4/6E48E8AB-DC00-419E-9704-06DD46E5F81D/NDP472-KB4054530-x86-x64-AllOS-ENU.exe"
$pkg_description=".Net 4.7.2 Framework Runtime"
$pkg_upstream_url="https://dotnet.microsoft.com/download"
$pkg_shasum="c908f0a5bea4be282e35acba307d0061b71b8b66ca9894943d3cbb53cad019bc"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {}
function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename"
}
