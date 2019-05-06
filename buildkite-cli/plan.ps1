$pkg_name="buildkite-cli"
$pkg_origin="core"
$pkg_version="0.4.1"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("MIT")
$pkg_description="A command line interface for Buildkite"
$pkg_deps=@("core/git", "core/buildkite-agent")
$pkg_source="https://github.com/buildkite/cli/releases/download/v${pkg_version}/bk-windows-amd64-${pkg_version}.exe"
$pkg_filename="bk-windows-amd64-${pkg_version}.exe"
$pkg_shasum="2a8cd25eabdaf9aaf654ca28779ed1bdb628b351668bd6804f966f68b2fc96f1"
$pkg_upstream_url="https://buildkite.com"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/bk.exe"
}
