pkg_name=goreplay
pkg_origin=core
pkg_version="0.16.1"
pkg_license=('LGPL-3.0')
pkg_description="GoReplay is an open-source tool for capturing and replaying live HTTP traffic into a test environment in order to continuously test your system with real data."
pkg_upstream_url="https://goreplay.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/buger/goreplay/releases/download/v${pkg_version}/gor_${pkg_version}_x64.tar.gz"
pkg_filename="gor_${pkg_version}_x64.tar.gz"
pkg_shasum="25587cd4c88b0608ac4004a3c7c9722e10a9086cfcc77d1fb26d9f07bd48d245"
pkg_bin_dirs=(bin)

# The pkg_filename does not extract into a folder. We need to force it.
do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  mkdir "${pkg_name}-${pkg_version}"
  tar -xvf ${pkg_filename} --directory "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D goreplay "${pkg_prefix}/bin/goreplay"
}
