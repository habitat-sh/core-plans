pkg_name=sassc
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=3.6.0
pkg_source="https://github.com/sass/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=dac8d83339c3c8fc6b9599e2ff1e0a0ae833ab0e65d4370b9c69bde18f8ec676
libsass_shasum=b4b962a30bcd99adf0162a8eac7e1be94612b1c19912237f53d9a2c11d375169
pkg_license=('MIT')
pkg_description='libsass command line driver'
pkg_upstream_url=https://github.com/sass/sassc
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/make
  core/gcc
  core/coreutils
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_download() {
  do_default_download
  download_file \
    "https://github.com/sass/libsass/archive/${pkg_version}.tar.gz" \
    "libsass.tar.gz" \
    "${libsass_shasum}"
  verify_file \
    "libsass.tar.gz" \
    "${libsass_shasum}"
}

do_unpack() {
  do_default_unpack
  tar -xzf "${HAB_CACHE_SRC_PATH}/libsass.tar.gz" -C "${HAB_CACHE_SRC_PATH}"
}

do_build() {
  export SASS_LIBSASS_PATH="${HAB_CACHE_SRC_PATH}/libsass-${pkg_version}"
  echo "${pkg_version}" > "${HAB_CACHE_SRC_PATH}/sassc-${pkg_version}/VERSION"
  echo "${pkg_version}" > "${HAB_CACHE_SRC_PATH}/libsass-${pkg_version}/VERSION"
  make
}

do_install() {
  install -D ./bin/sassc "${pkg_prefix}/bin/sassc"
}
