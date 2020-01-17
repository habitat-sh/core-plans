pkg_name="psscriptanalyzer"
pkg_origin="core"
pkg_version="1.18.3"
pkg_license=('MIT')
pkg_upstream_url="https://github.com/PowerShell/PSScriptAnalyzer"
pkg_description="PSScriptAnalyzer is the ubiquitous linter for PowerShell"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/PowerShell/PSScriptAnalyzer/releases/download/$pkg_version/PSScriptAnalyzer.zip"
pkg_shasum="8fcad735102fe3eaa9e090ec2ac09cfb7b1b2808ba00df1b2ff4c9a7383fc384"
pkg_deps=("core/powershell")

do_build() {
  return 0
}

do_install() {
  mkdir "$pkg_prefix/module"
  cp -rf "$HAB_CACHE_SRC_PATH"/* "$pkg_prefix"/module
}

do_check() {
  version=$(pwsh --command "Import-Module $HAB_CACHE_SRC_PATH/PSScriptAnalyzer.psd1; (Get-Command Invoke-ScriptAnalyzer).Version -join ''")
  if [ "$version" != "$pkg_version" ]; then
    build_line "Check failed to confirm PSScriptAnalyzer version as $pkg_version got $version"
    return 1
  fi
}
