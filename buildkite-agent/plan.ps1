$pkg_name="buildkite-agent"
$pkg_origin="core"
$pkg_version="3.29.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("MIT")
$pkg_description="The Buildkite Agent is an open-source toolkit written in Golang for securely running build jobs on any device or network."
$pkg_source="https://github.com/buildkite/agent/releases/download/v${pkg_version}/buildkite-agent-windows-amd64-${pkg_version}.zip"
$pkg_filename="buildkite-agent-windows-amd64-${pkg_version}.zip"
$pkg_shasum="24c4aae7079aaf84e82679d963d301f56ea5e775646d29cae5995381c352e8e6"
$pkg_upstream_url="https://buildkite.com"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/buildkite-agent.exe" "$pkg_prefix/bin"
}
