$pkg_name="dotnet-45-runtime"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Microsoft Software License")
$pkg_source="http://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/dotnetfx45_full_x86_x64.exe"
$pkg_description=".Net 4.5 Framework Runtime"
$pkg_upstream_url="https://dotnet.microsoft.com/download"
$pkg_shasum="a04d40e217b97326d46117d961ec4eda455e087b90637cb33dd6cc4a2c228d83"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {}
function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename"
}
