$pkg_name="psscriptanalyzer"
$pkg_origin="core"
$pkg_version="1.20.0"
$pkg_license=@('MIT')
$pkg_upstream_url="https://github.com/PowerShell/PSScriptAnalyzer"
$pkg_description="PSScriptAnalyzer is the ubiquitous linter for PowerShell"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/PowerShell/PSScriptAnalyzer/archive/refs/tags/$pkg_version.zip"
$pkg_shasum="4f192475e82598e5868a107846a44fb12f4bd0849e2dcc22b6c1200be5974f6f"

function Invoke-Install {
    mkdir "$pkg_prefix/module"
    Copy-Item * "$pkg_prefix/module" -Recurse -Force
}
