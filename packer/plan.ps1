$pkg_name="packer"
$pkg_origin="core"
$pkg_version="1.8.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MPL2')
$pkg_bin_dirs=@("bin")
$pkg_source="https://releases.hashicorp.com/packer/${pkg_version}/packer_${pkg_version}_windows_amd64.zip"
$pkg_shasum="6c1b00069e4924e97b362b6c72a7315960487aaeb287bfdec717468ca2b50e9a"

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version/$pkg_name.exe" $pkg_prefix\bin
}
