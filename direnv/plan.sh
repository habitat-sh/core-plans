pkg_name=direnv
pkg_origin=core
pkg_version="2.18.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/$pkg_name/$pkg_name/releases/download/v$pkg_version/$pkg_name.linux-amd64"
pkg_filename="$pkg_name.linux-amd64"
pkg_shasum="583103a182e22b42665f09741eef1cb4ed2b1e278878e21f224ef2358c759a41"
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
  install -m 0755 "${HAB_CACHE_SRC_PATH}/${pkg_filename}" "${pkg_prefix}/bin/${pkg_name}"
}

do_strip() {
  return 0
}
