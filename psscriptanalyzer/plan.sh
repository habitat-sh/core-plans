pkg_name="psscriptanalyzer"
pkg_origin="core"
pkg_version="1.20.0"
pkg_license=('MIT')
pkg_upstream_url="https://github.com/PowerShell/PSScriptAnalyzer"
pkg_description="PSScriptAnalyzer is the ubiquitous linter for PowerShell"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/PowerShell/PSScriptAnalyzer/releases/download/$pkg_version/PSScriptAnalyzer.$pkg_version.nupkg"
pkg_shasum=52b442c513d327129be228ab031a38a91c26f01187b179e9068d918a2c38a466
pkg_deps=("core/powershell")

do_unpack() {
  unzip -o "${HAB_CACHE_SRC_PATH}/${pkg_filename}" -d "${SRC_PATH}"
}

do_build() {
  return 0
}

do_install() {
  mkdir "$pkg_prefix/module"
  cp -rf "${SRC_PATH}"/* "$pkg_prefix"/module
}

do_check() {
  version=$(pwsh --command "Import-Module ${SRC_PATH}/PSScriptAnalyzer.psd1; (Get-Command Invoke-ScriptAnalyzer).Version -join ''")
  if [ "$version" != "$pkg_version" ]; then
    build_line "Check failed to confirm PSScriptAnalyzer version as $pkg_version got $version"
    return 1
  fi
}
