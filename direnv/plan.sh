pkg_name=direnv
pkg_origin=core
pkg_version="2.28.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}.linux-amd64"
pkg_filename="${pkg_name}.linux-amd64"
pkg_shasum="6131c0c0eb6a744abad96c176bb311a20c625a5a18b1e02459b1845652f241b7"
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
