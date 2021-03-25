pkg_name=percona-xtrabackup
pkg_origin=core
pkg_version=2.4.18
pkg_description="Percona xtrabackup utilities"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://www.percona.com/software/mysql-database/percona-xtrabackup"
pkg_license=('GPL-2.0')
pkg_source="http://github.com/percona/percona-xtrabackup/archive/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="21f7dd9ad0f8a8249a7710ab5c76c31e9a4edb04d3ac716f6803cfc8f47b6fa3"
pkg_dirname="percona-xtrabackup-percona-xtrabackup-${pkg_version}"
pkg_build_deps=(
  core/m4
  core/bison
  core/boost159
  core/cmake
  core/gcc
  core/make
  core/ncurses
  core/vim
)
pkg_deps=(
  core/curl
  core/gcc-libs
  core/glibc
  core/libaio
  core/libev
  core/libgcrypt
  core/libgpg-error
  core/nghttp2
  core/openssl
  core/zlib
)
pkg_bin_dirs=(bin)

do_prepare() {
  if [ -f CMakeCache.txt ]; then
    rm CMakeCache.txt
  fi
  sed -i 's/^.*abi_check.*$/#/' CMakeLists.txt

  export CXXFLAGS="$CFLAGS -Wno-error=implicit-fallthrough -fpermissive"
  export CPPFLAGS="$CPPFLAGS -Wno-error=implicit-fallthrough"
}

do_build() {
  export LD_LIBRARY_PATH GCRYPT_INCLUDE_DIR GCRYPT_LIB
  LD_LIBRARY_PATH="$(pkg_path_for core/libgcrypt)/lib"
  GCRYPT_INCLUDE_DIR=$(pkg_path_for core/libgcrypt)/lib
  GCRYPT_LIB=$(pkg_path_for core/libgcrypt)
  cmake . -DCMAKE_PREFIX_PATH="$(pkg_path_for core/ncurses)" -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DBUILD_CONFIG=xtrabackup_release -DWITH_MAN_PAGES=OFF -DWITH_BOOST="$(pkg_path_for core/boost159)/include" \
    -DCURL_LIBRARY="$(pkg_path_for core/curl)/lib/libcurl.so" -DCURL_INCLUDE_DIR="$(pkg_path_for core/curl)/include" \
    -DLIBEV_INCLUDE_DIRS="$(pkg_path_for core/libev)/include"	-DGCRYPT_LIB="$(pkg_path_for core/libgcrypt)/lib/libgcrypt.so" \
    -DGCRYPT_INCLUDE_DIR="$(pkg_path_for core/libgcrypt)/include" -DGPG_ERROR_LIB="$(pkg_path_for core/libgpg-error)/lib/libgpg-error.so" \
    -DLIBEV_LIB="$(pkg_path_for core/libev)/lib/libev.so" -DZLIB_LIBRARY="$(pkg_path_for core/zlib)/lib/libz.so"
  make
}

do_install() {
  make install
  rm -rf "${pkg_prefix}/xtrabackup-test"
}
