pkg_name=libltdl
pkg_derivation=chef
pkg_version=2.4.6
pkg_license=('GPL')
pkg_maintainer="Jamie Winsor <reset@chef.io>"
pkg_source=https://ftp.gnu.org/pub/gnu/libtool/libtool-${pkg_version}.tar.xz
pkg_deps=(chef/glibc)
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_dirname=libtool-${pkg_version}
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_shasum=7c87a8c2c8c0fc9cd5019e402bed4292462d00a718a7cd5f11218153bf28b26f
pkg_gpg_key=3853DA6B

build() {
  ./configure
  make
}

install() {
  make install prefix=${pkg_prefix}
}
