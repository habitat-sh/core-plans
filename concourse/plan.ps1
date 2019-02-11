$pkg_name="concourse"
$pkg_origin="core"
$pkg_version="4.2.2"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=('Apache-2.0')
$pkg_description="CI that scales with your project"
$pkg_upstream_url="https://concourse.ci"
$pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}_windows_amd64.exe"
$pkg_filename="${pkg_name}.exe"
$pkg_shasum="d1ae2b0c6f2b10b11d793527b55a48813c421a6aa73b75a8496f093878114097"

$pkg_bin_dirs=@("bin")

function Invoke-Unpack { }

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/" -Force
}
