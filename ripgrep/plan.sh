pkg_name=ripgrep
pkg_origin=core
pkg_version="11.0.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT' 'Unlicense')
pkg_source="https://github.com/BurntSushi/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}-x86_64-unknown-linux-musl.tar.gz"
pkg_dirname="${pkg_name}-${pkg_version}-x86_64-unknown-linux-musl"
pkg_shasum="ce74cabac9b39b1ad55837ec01e2c670fa7e965772ac2647b209e31ead19008c"
pkg_bin_dirs=(bin)
pkg_description="ripgrep combines the usability of The Silver Searcher with the raw speed of grep."
pkg_upstream_url="https://github.com/BurntSushi/ripgrep"

do_build() {
  return 0
}

do_install() {
  install -v -m 0755 "${CACHE_PATH}/rg" "${pkg_prefix}/bin/rg"
}

do_strip() {
  return 0
}
