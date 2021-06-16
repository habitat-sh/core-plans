$pkg_name="lessmsi"
$pkg_origin="core"
$pkg_version="1.8.1"
$pkg_license=('MIT')
$pkg_upstream_url="http://lessmsi.activescott.com/"
$pkg_description="A tool to view and extract the contents of a Windows Installer (.msi) file."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/activescott/lessmsi/releases/download/v$pkg_version/lessmsi-v${pkg_version}.zip"
$pkg_shasum="1309c1ba220806ca54c4603e53463c4ab50a9d1dc74d9da7abfe0822f2778012"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/lessmsi-v${pkg_version}.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
