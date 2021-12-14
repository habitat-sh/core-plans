pkg_name=mysql-client
pkg_origin=core
pkg_version=5.7.35
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0')
pkg_source=http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-${pkg_version}.tar.gz
pkg_shasum=3b4d3d503a32e3779a386126d79586804b199b455d646c36e58cb50ea75230e9
pkg_upstream_url=https://www.mysql.com/
pkg_description="MySQL Client Tools"
pkg_deps=(
  core/coreutils
  core/gawk
  core/gcc-libs
  core/glibc
  core/grep
  core/inetutils
  core/ncurses
  core/openssl
  core/pcre
  core/perl
  core/procps-ng
  core/sed
)
pkg_build_deps=(
  core/boost159
  core/cmake
  core/diffutils
  core/gcc
  core/make
  core/patch
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname="mysql-${pkg_version}"

do_build() {
  cmake . -DLOCAL_BOOST_DIR="$(pkg_path_for core/boost159)" \
          -DBOOST_INCLUDE_DIR="$(pkg_path_for core/boost159)"/include \
          -DWITH_BOOST="$(pkg_path_for core/boost159)" \
          -DCURSES_LIBRARY="$(pkg_path_for core/ncurses)/lib/libcurses.so" \
          -DCURSES_INCLUDE_PATH="$(pkg_path_for core/ncurses)/include" \
          -DWITH_SSL=yes \
          -DOPENSSL_INCLUDE_DIR="$(pkg_path_for core/openssl)/include" \
          -DOPENSSL_LIBRARY="$(pkg_path_for core/openssl)/lib/libssl.so" \
          -DCRYPTO_LIBRARY="$(pkg_path_for core/openssl)/lib/libcrypto.so" \
          -DWITHOUT_SERVER:BOOL=ON \
          -DCMAKE_INSTALL_PREFIX="$pkg_prefix"
  make --jobs="$(nproc)"
}

do_install() {
  do_default_install

  # Remove things we don't need
  rm "$pkg_prefix/lib/"*.a "$pkg_prefix/bin/mysqld_"*

  fix_interpreter "$pkg_prefix/bin/mysqldumpslow" core/perl bin/perl
}

do_check() {
  ctest
}
