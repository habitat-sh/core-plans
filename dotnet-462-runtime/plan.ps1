$pkg_name="dotnet-462-runtime"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Microsoft Software License")
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/8e396c75-4d0d-41d3-aea8-848babc2736a/570f7c7e1975df353a4652ae70b3e0ac/ndp462-kb3151802-web.exe"
$pkg_description=".Net 4.6.2 Framework Runtime"
$pkg_upstream_url="https://dotnet.microsoft.com/download"
$pkg_shasum="67242c8fe953d454edb4171023343f33740e3d16e8469a4b0c11bd42eb85f3fa"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {}
function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename"
}
