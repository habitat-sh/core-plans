$pkg_name="dotnet-462-runtime"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Microsoft Software License")
$pkg_source="https://download.microsoft.com/download/F/9/4/F942F07D-F26F-4F30-B4E3-EBD54FABA377/NDP462-KB3151800-x86-x64-AllOS-ENU.exe"
$pkg_description=".Net 4.6.2 Framework Runtime"
$pkg_upstream_url="https://dotnet.microsoft.com/download"
$pkg_shasum="28886593e3b32f018241a4c0b745e564526dbb3295cb2635944e3a393f4278d4"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {}
function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename"
}
