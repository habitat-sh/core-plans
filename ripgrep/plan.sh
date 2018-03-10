pkg_name=ripgrep
pkg_origin=core
pkg_version="0.5.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT' 'Unlicense')
pkg_source="https://github.com/BurntSushi/$pkg_name/releases/download/$pkg_version/$pkg_name-$pkg_version-x86_64-unknown-linux-musl.tar.gz"
pkg_dirname="$pkg_name-$pkg_version-x86_64-unknown-linux-musl"
pkg_shasum="ecb53ed7e9f3a1ebea76a4e517af42ffe1e778eab3b413200a3e543d033f68f5"
pkg_bin_dirs=(bin)
pkg_description="ripgrep combines the usability of The Silver Searcher with the raw speed of grep."
pkg_upstream_url="https://github.com/BurntSushi/ripgrep"

do_build() {
  return 0
}

do_install() {
  install -v -m 0755 "$CACHE_PATH/rg" "$pkg_prefix/bin/rg"
}

do_strip() {
  return 0
}
