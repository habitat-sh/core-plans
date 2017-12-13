pkg_name=exercism
pkg_origin=core
pkg_version="2.4.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/$pkg_name/cli/releases/download/v$pkg_version/$pkg_name-linux-64bit.tgz"
pkg_shasum="bea54bee63105970ae75be889f78bece1377056e687eca59e6b32b9d58ea6502"
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
