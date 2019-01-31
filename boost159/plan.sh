pkg_name=boost159
pkg_origin=core
pkg_description='Boost provides free peer-reviewed portable C++ source libraries.'
pkg_upstream_url='http://www.boost.org/'
pkg_version=1.59.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Boost Software License')
pkg_dirname="boost_${pkg_version//./_}"
pkg_source="http://downloads.sourceforge.net/project/boost/boost/${pkg_version}/${pkg_dirname}.tar.gz"
pkg_shasum="47f11c8844e579d02691a607fbd32540104a9ac7a2534a8ddaef50daf502baac"
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
  ./b2 install --prefix="$pkg_prefix" -q --debug-configuration -j"$(nproc)"
}
