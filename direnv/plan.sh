pkg_name=direnv
pkg_origin=core
pkg_version="2.19.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}.linux-amd64"
pkg_filename="${pkg_name}.linux-amd64"
pkg_shasum="3341afc4a2255a680e446230f9db5cee66f2f208f3c43cb251ba908957fe7636"
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
