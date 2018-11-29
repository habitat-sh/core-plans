pkg_name=direnv
pkg_origin=core
pkg_version="2.18.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}.linux-amd64"
pkg_filename="${pkg_name}.linux-amd64"
pkg_shasum="a53e3c23160e881bfb977b282bacddd3731d0f2a972ce5667a567cbd6e825ed1"
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
