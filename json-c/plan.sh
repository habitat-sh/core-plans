pkg_name=json-c
pkg_origin=core
pkg_version=0.15
pkg_description="A JSON implementation in C"
pkg_upstream_url=https://github.com/json-c/json-c
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://s3.amazonaws.com/json-c_releases/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b8d80a1ddb718b3ba7492916237bbf86609e9709fb007e7f7d4322f02341a4c6
pkg_build_deps=(
  core/autoconf
  core/busybox-static
  core/gcc
  core/cmake
  core/make
)
pkg_deps=(
  core/glibc
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib64)
pkg_pconfig_dirs=(lib64/pkgconfig)

do_clean() {
  rm -rf "${HAB_CACHE_SRC_PATH}"/json-c-build
}

do_build() {
  mkdir "${HAB_CACHE_SRC_PATH}"/json-c-build
  cd "${HAB_CACHE_SRC_PATH}"/json-c-build
  cmake -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" "${HAB_CACHE_SRC_PATH}"/"${pkg_dirname}"
}

do_install() {
  cd "${HAB_CACHE_SRC_PATH}"/json-c-build
  make install
}

do_check() {
  cd "${HAB_CACHE_SRC_PATH}"/json-c-build
  make
  make test
}
