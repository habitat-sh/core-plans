pkg_name=cmake
pkg_origin=core
_base_version=3.11
pkg_version=${_base_version}.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('BSD-3-Clause')
pkg_description="CMake is an open-source, cross-platform family of tools designed to build, test and package software"
pkg_upstream_url="https://cmake.org/"
pkg_source="https://cmake.org/files/v${_base_version}/cmake-${pkg_version}.tar.gz"
pkg_shasum=c313bee371d4d255be2b4e96fd59b11d58bc550a7c78c021444ae565709a656b
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/curl
  core/libarchive
  edavis/libuv
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/make
  core/gcc
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  ./bootstrap \
    --system-libs \
    --prefix="${pkg_prefix}" \
    --no-system-jsoncpp \
    --no-system-librhash \
    --parallel="$(nproc)"
  make -j "$(nproc)"
}

do_check() {
  make test
}
