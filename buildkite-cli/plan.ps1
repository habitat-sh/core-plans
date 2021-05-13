$pkg_name="buildkite-cli"
$pkg_origin="core"
$pkg_version="0.5.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("MIT")
$pkg_description="A command line interface for Buildkite"
$pkg_deps=@("core/git", "core/buildkite-agent")
$pkg_source="https://github.com/buildkite/cli/releases/download/v${pkg_version}/bk-windows-amd64-${pkg_version}.exe"
$pkg_filename="bk-windows-amd64-${pkg_version}.exe"
$pkg_shasum="24d8a06f75f1916890fa8acb92dee71e01b3943daf4e094f44cce48a8834f7f2"
$pkg_upstream_url="https://buildkite.com"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/bk.exe"
}
