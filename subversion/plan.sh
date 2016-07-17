pkg_name=subversion
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=1.9.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="Enterprise-class centralized version control for the masses"
pkg_upstream_url=https://subversion.apache.org/
pkg_source=https://archive.apache.org/dist/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.bz2
pkg_shasum=1267f9e2ab983f260623bee841e6c9cc458bf4bf776238ed5f100983f79e9299
pkg_deps=(
  core/gcc-libs
  core/serf
  core/zlib
)
pkg_build_deps=(
  core/apr
  core/apr-util
  core/coreutils
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
  core/python2
  core/sqlite
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix="${pkg_prefix}" --with-serf="$(pkg_path_for serf)"
  make
}

do_check() {
  make check
}
