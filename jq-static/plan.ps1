$pkg_name="jq-static"
$pkg_origin="core"
$pkg_version="1.6"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("MIT")
$pkg_upstream_url="https://stedolan.github.io/jq/"
$pkg_description="jq is a lightweight and flexible command-line JSON processor."
$pkg_source="https://github.com/stedolan/jq/releases/download/jq-$pkg_version/jq-win64.exe"
$pkg_shasum="a51d36968dcbdeabb3142c6f5cf9b401a65dc3a095f3144bd0c118d5bb192753"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack { }

function Invoke-Install {
    Copy-Item $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix/bin/jq.exe
}
