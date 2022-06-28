$pkg_name="concourse"
$pkg_origin="core"
$pkg_version="4.2.3"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=('Apache-2.0')
$pkg_description="CI that scales with your project"
$pkg_upstream_url="https://concourse.ci"
$pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}_windows_amd64.exe"
$pkg_filename="${pkg_name}.exe"
$pkg_shasum="314b33c363126fcc81133f9678a0f671a3c449d86310015322425f037a5653c1"

$pkg_bin_dirs=@("bin")

function Invoke-Unpack { }

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/" -Force
}
