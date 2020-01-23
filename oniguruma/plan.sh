pkg_name=oniguruma
pkg_origin=core
pkg_version=6.9.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Oniguruma is a modern and flexible regular expressions library"
pkg_upstream_url="https://github.com/kkos/oniguruma"
pkg_license=("BSD-2-Clause")
pkg_source="https://github.com/kkos/oniguruma/archive/v${pkg_version}.tar.gz"
pkg_shasum=aea68e5843b627f5fe6d3d6b598845b7f3622910e0568408e7cc2fa6b3690b87
pkg_deps=(
  core/glibc
  core/coreutils
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/libtool
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  libtoolize
  ./autogen.sh
  ./configure \
    --prefix "${pkg_prefix}"
  make
}
