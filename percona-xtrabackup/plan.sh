pkg_name=percona-xtrabackup
pkg_origin=core
pkg_version=2.3.5
pkg_source=http://github.com/percona/percona-xtrabackup/archive/${pkg_name}-${pkg_version}.tar.gz
pkg_upstream_url=https://www.percona.com/software/mysql-database/percona-xtrabackup
pkg_shasum=1787623cb9ea331fb242992c4fcf3f88ee61045dcd42be027884bc7d373dcdae
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Percona xtrabackup utilities"
pkg_license=('GPL-2.0')
pkg_bin_dirs=(bin)
pkg_build_deps=(core/m4 core/make core/gcc core/bison core/cmake core/mysql core/libaio
  core/boost159)
pkg_deps=(core/bash core/iproute2 core/gnupg core/pkg-config core/glibc core/gcc-libs core/ncurses
  core/vim core/curl core/libev core/openssl core/zlib core/libgcrypt core/libgpg-error
  core/libtool)
pkg_dirname=percona-xtrabackup-percona-xtrabackup-${pkg_version}

do_prepare() {
  if [ -f CMakeCache.txt ]; then
    rm CMakeCache.txt
  fi
  sed -i'' 's/^.*abi_check.*$/#/' CMakeLists.txt
  export CXXFLAGS="$CFLAGS"
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
    -DLIBEV_LIB="$(pkg_path_for core/libev)/lib/libev.so"
  make
}

do_install() {
  make install
}
