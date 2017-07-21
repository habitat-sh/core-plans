pkg_name=direnv
pkg_origin=core
pkg_version="2.12.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/$pkg_name/$pkg_name/releases/download/v$pkg_version/$pkg_name.linux-amd64"
pkg_filename="$pkg_name.linux-amd64"
pkg_shasum="48910b9b2b3e629cc123b48528ef2c51e950d989aaf09cfe07ffcf22144b54df"
pkg_bin_dirs=(bin)
pkg_description="direnv is an environment switcher for the shell."
pkg_upstream_url="https://direnv.net/"

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  install -m 0755 "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_name"
}

do_strip() {
  return 0
}
