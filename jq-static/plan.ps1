$pkg_name="jq-static"
$pkg_origin="core"
$pkg_version="1.5"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_source="https://github.com/stedolan/jq/releases/download/jq-$pkg_version/jq-win64.exe"
$pkg_shasum="ebecd840ba47efbf66822868178cc721a151060937f7ac406e3d31bd015bde94"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack { }

function Invoke-Install {
  Copy-Item $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix/bin/jq.exe
}
