pkg_name="psscriptanalyzer"
pkg_origin="core"
pkg_version="1.19.1"
pkg_license=('MIT')
pkg_upstream_url="https://github.com/PowerShell/PSScriptAnalyzer"
pkg_description="PSScriptAnalyzer is the ubiquitous linter for PowerShell"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/PowerShell/PSScriptAnalyzer/releases/download/$pkg_version/PSScriptAnalyzer.zip"
pkg_shasum=151a4e6df2bc5a66192ee5db4af4132e17159860861191646cffd38d06ce71a2
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
