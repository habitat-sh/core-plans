pkg_name=delmo
pkg_origin=core
pkg_version="0.6.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/bodymindarts/delmo/releases/download/v${pkg_version}/delmo-linux-amd64"
pkg_filename="${pkg_name}"
pkg_shasum="1d7a3a27f5c65a281315325bda9b87c176cd3b6f82b26e4eab290bbe2eefb221"
pkg_bin_dirs=(bin)
pkg_description="DelMo is a tool to test systems running within multiple docker containers."
pkg_upstream_url="https://github.com/bodymindarts/delmo"

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  mv "${HAB_CACHE_SRC_PATH}/${pkg_name}" "${SRC_PATH}/${pkg_name}"
  install -D "${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
