pkg_name="pester"
pkg_origin="core"
pkg_version="4.10.1"
pkg_license=('Apache-2.0')
pkg_upstream_url="https://github.com/pester/Pester"
pkg_description="Pester is the ubiquitous test and mock framework for PowerShell"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/pester/Pester/archive/$pkg_version.zip"
pkg_shasum="b7161234bf0b0e750038f3e00ec73a95fabb136d52502c4736c7eb610bebd82e"
pkg_deps=("core/powershell")
pkg_bin_dirs=("module/bin")

do_build() {
  return 0
}

do_install() {
  cp -rf "$HAB_CACHE_SRC_PATH"/Pester-$pkg_version/* "$pkg_prefix"/module
  chmod +x "$pkg_prefix"/module/bin/pester.bat
}

do_check() {
  version=$(pwsh --command "Import-Module $HAB_CACHE_SRC_PATH/Pester-$pkg_version/Pester.psd1; (Get-Command Invoke-Pester).Version -join ''")
  if [ "$version" != "$pkg_version" ]; then
    build_line "Check failed to confirm pester version as $pkg_version got $version"
    return 1
  fi
}
