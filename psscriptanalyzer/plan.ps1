$pkg_name="psscriptanalyzer"
$pkg_origin="core"
$pkg_version="1.18.1"
$pkg_license=@('MIT')
$pkg_upstream_url="https://github.com/PowerShell/PSScriptAnalyzer"
$pkg_description="PSScriptAnalyzer is a static code checker for Windows PowerShell modules and scripts."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com//PowerShell/PSScriptAnalyzer/archive/$pkg_version.zip"
$pkg_shasum="fcb0d0d44c78771c75cf8de648eb7395ca049ad08e136094670aa3b63dce01f9"
$pkg_bin_dirs=@("module/bin")

function Invoke-Build {
  cd "$pkg_name-$pkg_version"
  .\build.ps1
}

function Invoke-Install {
  Copy-Item "PSScriptAnalyzer-$pkg_version\out\PSScriptAnalyzer\$pkg_version\*" "$pkg_prefix/module" -Recurse -Force
}
