pkg_name=mysql-client
pkg_origin=core
pkg_version=5.7.14
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0')
pkg_source=http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-${pkg_version}.tar.gz
pkg_shasum=f7415bdac2ca8bbccd77d4f22d8a0bdd7280b065bd646a71a506b77c7a8bd169

pkg_upstream_url=https://www.mysql.com/
pkg_description="MySQL Client Tools"

pkg_deps=(
  core/glibc
  core/gcc-libs
  core/coreutils
  core/sed
  core/gawk
  core/grep
  core/pcre
  core/procps-ng
  core/inetutils
  core/ncurses
  core/openssl
)

pkg_build_deps=(
  core/cmake
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  # -- MySQL currently requires boost_1_59_0
  core/boost159
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname="mysql-${pkg_version}"

do_build() {
  cmake . -DLOCAL_BOOST_DIR="$(pkg_path_for core/boost159)" \
          -DBOOST_INCLUDE_DIR="$(pkg_path_for core/boost159)"/include \
          -DWITH_BOOST="$(pkg_path_for core/boost159)" \
          -DWITH_SSL=yes \
          -DWITHOUT_SERVER:BOOL=ON \
          -DCMAKE_INSTALL_PREFIX="$pkg_prefix"
  make
}

do_check() {
  ctest
}
