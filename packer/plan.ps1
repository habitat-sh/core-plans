$pkg_name="packer"
$pkg_origin="core"
$pkg_version="1.3.5"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MPL2')
$pkg_bin_dirs=@("bin")
$pkg_source="https://releases.hashicorp.com/packer/${pkg_version}/packer_${pkg_version}_windows_amd64.zip"
$pkg_shasum="57d30d5d305cf877532e93526c284438daef5db26d984d16ee85e38a7be7cfbb"

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version/$pkg_name.exe" $pkg_prefix\bin
}
