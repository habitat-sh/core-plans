$pkg_name="dotnet-472-runtime"
$pkg_origin="core"
$pkg_version="4.7.2"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Microsoft Software License")
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/1f5af042-d0e4-4002-9c59-9ba66bcf15f6/124d2afe5c8f67dfa910da5f9e3db9c1/ndp472-kb4054531-web.exe"
$pkg_description=".Net 4.7.2 Framework Runtime"
$pkg_upstream_url="https://dotnet.microsoft.com/download"
$pkg_shasum="151b1c11f625e7122d517b6a1778841df8ff168d931c41730f59b9e4b8bcbe36"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {}
function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename"
}
