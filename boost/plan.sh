pkg_name=boost
pkg_origin=core
pkg_description='Boost provides free peer-reviewed portable C++ source libraries.'
pkg_upstream_url='http://www.boost.org/'
pkg_version=1.75.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Boost Software License')
pkg_source=http://downloads.sourceforge.net/project/boost/boost/${pkg_version}/boost_1_75_0.tar.gz
pkg_shasum=aeb26f80e80945e82ee93e5939baebdca47b9dee80a07d3144be1e1a6a66dd6a
pkg_dirname=boost_1_75_0

pkg_deps=(
  core/glibc
  core/gcc-libs
  core/zlib
)

pkg_build_deps=(
  core/glibc
  core/gcc-libs
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/python2
  core/libxml2
  core/libxslt
  core/openssl
  core/which
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  ./bootstrap.sh --prefix="$pkg_prefix"
}

do_install() {
  export NO_BZIP2=1
  export ZLIB_LIBPATH
  ZLIB_LIBPATH="$(pkg_path_for core/zlib)/lib"
  export ZLIB_INCLUDE
  ZLIB_INCLUDE="$(pkg_path_for core/zlib)/include"
  ./b2 install --prefix="$pkg_prefix" -q --debug-configuration
}
