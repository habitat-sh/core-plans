$pkg_name="packer"
$pkg_origin="core"
$pkg_version="1.3.3"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MPL2')
$pkg_bin_dirs=@("bin")
$pkg_source="https://releases.hashicorp.com/packer/${pkg_version}/packer_${pkg_version}_windows_amd64.zip"
$pkg_shasum="02e35d7ec6dbd009c117f9731c42b8ba67fd6d53ec05f57849445f316ae8f817"

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version/$pkg_name.exe" $pkg_prefix\bin
}
