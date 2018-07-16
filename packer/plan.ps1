$pkg_name="packer"
$pkg_origin="core"
$pkg_version="1.2.4"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MPL2')
$pkg_bin_dirs=@("bin")
$pkg_source="https://releases.hashicorp.com/packer/${pkg_version}/packer_${pkg_version}_windows_amd64.zip"
$pkg_shasum="97c030add9c3d772f445df7bae3f0e70c4b67d4ed13c39e02b4cc338d8c93016"

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version/$pkg_name.exe" $pkg_prefix\bin
}

