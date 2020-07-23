$pkg_name="packer"
$pkg_origin="core"
$pkg_version="1.5.6"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MPL2')
$pkg_bin_dirs=@("bin")
$pkg_source="https://releases.hashicorp.com/packer/${pkg_version}/packer_${pkg_version}_windows_amd64.zip"
$pkg_shasum="60c5220bd2617e95949a930625c3276f704ffbb54039312a0a040379786ac49e"

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version/$pkg_name.exe" $pkg_prefix\bin
}
