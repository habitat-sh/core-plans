$pkg_name="packer"
$pkg_origin="core"
$pkg_version="1.4.5"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MPL2')
$pkg_bin_dirs=@("bin")
$pkg_source="https://releases.hashicorp.com/packer/${pkg_version}/packer_${pkg_version}_windows_amd64.zip"
$pkg_shasum="5da1b38beaad735a8b7390865d33e5f60d830fa93e5485f593aae2254dcc4ad8"

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version/$pkg_name.exe" $pkg_prefix\bin
}
