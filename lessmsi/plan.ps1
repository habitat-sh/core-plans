$pkg_name="lessmsi"
$pkg_origin="core"
$pkg_version="1.6.1"
$pkg_license=('MIT')
$pkg_upstream_url="http://lessmsi.activescott.com/"
$pkg_description="A tool to view and extract the contents of a Windows Installer (.msi) file."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/activescott/lessmsi/releases/download/v$pkg_version/lessmsi-v${pkg_version}.zip"
$pkg_shasum="540b8801e08ec39ba26a100c855898f455410cecbae4991afae7bb2b4df026c7"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/lessmsi-v${pkg_version}.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
