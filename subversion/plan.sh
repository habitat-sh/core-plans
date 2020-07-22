pkg_name=subversion
pkg_origin=core
pkg_version=1.13.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="Enterprise-class centralized version control for the masses"
pkg_upstream_url=https://subversion.apache.org/
pkg_source="https://archive.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=bc50ce2c3faa7b1ae9103c432017df98dfd989c4239f9f8270bb3a314ed9e5bd
pkg_deps=(
  core/gcc-libs
  core/serf
  core/zlib
  core/lz4
  core/utf8proc
  core/sqlite
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
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --with-serf="$(pkg_path_for serf)"
  make
}

do_check() {
  make check
}
