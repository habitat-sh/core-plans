$pkg_name="pester"
$pkg_origin="core"
$pkg_version="4.8.1"
$pkg_license=@('Apache-2.0')
$pkg_upstream_url="https://github.com/pester/Pester"
$pkg_description="Pester is the ubiquitous test and mock framework for PowerShell"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/pester/Pester/archive/$pkg_version.zip"
$pkg_shasum="94304685630dc21d4077508c8d3c10aed17976ed2c5e41426793dc33c4e289c8"
$pkg_bin_dirs=@("module/bin")

function Invoke-Install {
  Copy-Item "pester-$pkg_version\*" "$pkg_prefix/module" -Recurse -Force
}
