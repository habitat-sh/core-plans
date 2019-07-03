$pkg_name="packer"
$pkg_origin="core"
$pkg_version="1.4.2"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MPL2')
$pkg_bin_dirs=@("bin")
$pkg_source="https://releases.hashicorp.com/packer/${pkg_version}/packer_${pkg_version}_windows_amd64.zip"
$pkg_shasum="0db7527e81672d51fc436081eff0e49e8873baee0564e427c5dc73a3f44fa840"

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version/$pkg_name.exe" $pkg_prefix\bin
}
