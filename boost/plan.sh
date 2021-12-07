pkg_name=boost
pkg_origin=core
pkg_description='Boost provides free peer-reviewed portable C++ source libraries.'
pkg_upstream_url='http://www.boost.org/'
pkg_version=1.77.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Boost Software License')
pkg_source=http://downloads.sourceforge.net/project/boost/boost/${pkg_version}/boost_1_77_0.tar.gz
pkg_shasum=5347464af5b14ac54bb945dc68f1dd7c56f0dad7262816b956138fc53bcc0131
pkg_dirname=boost_1_77_0

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
