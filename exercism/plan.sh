pkg_name=exercism
pkg_origin=core
pkg_version="3.0.11"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/$pkg_name/cli/releases/download/v$pkg_version/$pkg_name-linux-64bit.tgz"
pkg_shasum="bf0a55abc27cbdcfcc1cba4336eafdec3486b2434b96017b75d54ec8fc7a3360"
pkg_bin_dirs=(bin)
pkg_description="A Go based command line tool for exercism.io."
pkg_upstream_url="http://exercism.io/"

do_build() {
  return 0
}

do_install() {
  install -v -m 0755 "$HAB_CACHE_SRC_PATH/$pkg_name" "$pkg_prefix/bin/$pkg_name"
}

do_strip() {
  return 0
}
