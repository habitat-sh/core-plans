pkg_name=sassc
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=3.6.2
pkg_source="https://github.com/sass/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=608dc9002b45a91d11ed59e352469ecc05e4f58fc1259fc9a9f5b8f0f8348a03
libsass_shasum=0ecd2405f869901d70e7b1960259aac3f21a33c59a820a0a579a16f8f8dc43b9
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
}

do_verify() {
  do_default_verify
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
