$pkg_name="concourse"
$pkg_origin="core"
$pkg_version="4.2.1"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=('Apache-2.0')
$pkg_description="CI that scales with your project"
$pkg_upstream_url="https://concourse.ci"
$pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}_windows_amd64.exe"
$pkg_filename="${pkg_name}.exe"
$pkg_shasum="fef79d1fae5363d4ee7b072fbe1650fe9fe3d2fa9e5c00164228a41af1da4a1a"

$pkg_bin_dirs=@("bin")

function Invoke-Unpack { }

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/" -Force
}
