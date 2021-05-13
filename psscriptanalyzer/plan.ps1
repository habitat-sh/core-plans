$pkg_name="psscriptanalyzer"
$pkg_origin="core"
$pkg_version="1.19.1"
$pkg_license=@('MIT')
$pkg_upstream_url="https://github.com/PowerShell/PSScriptAnalyzer"
$pkg_description="PSScriptAnalyzer is the ubiquitous linter for PowerShell"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/PowerShell/PSScriptAnalyzer/releases/download/$pkg_version/PSScriptAnalyzer.zip"
$pkg_shasum="6938b5fed7fdd9277f1194bac2c802464f95e2e0838df065489d98eafdbcd901"

function Invoke-Install {
    mkdir "$pkg_prefix/module"
    Copy-Item * "$pkg_prefix/module" -Recurse -Force
}
