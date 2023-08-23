pkg_name=mariadb
pkg_origin=core
pkg_version=10.6.5
pkg_description="An open source monitoring software for networks and applications"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://mariadb.org/"
pkg_license=('GPL-2.0')
pkg_source="https://dlm.mariadb.com/1919970/MariaDB/mariadb-${pkg_version}/source/mariadb-${pkg_version}.tar.gz"
pkg_shasum="e0be040428d9a42a8bb4bd221b567ff2522cd6fa8906386273da4f03c5c20a8f"
pkg_deps=(
  core/gcc-libs
  core/ncurses
  core/zlib
  core/gnutls
  core/openssl
)
pkg_build_deps=(
  core/gcc
  core/make
  core/coreutils
  core/cmake
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_svc_user="hab"

do_prepare() {
  if [ -f CMakeCache.txt ]; then
    rm CMakeCache.txt
  fi

  sed -i 's/^.*abi_check.*$/#/' CMakeLists.txt
  sed -i "s@data/test@\${INSTALL_MYSQLTESTDIR}@g" sql/CMakeLists.txt
  CXXFLAGS="$CFLAGS"
  export CXXFLAGS

  OPENSSL_ROOT_DIR="$(pkg_path_for openssl)"
  export OPENSSL_ROOT_DIR
}

do_build() {
  cmake . -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
          -DCMAKE_PREFIX_PATH="$(pkg_path_for core/ncurses);$(pkg_path_for core/gnutls)" \
          -DCMAKE_BUILD_TYPE=Release \
          -DWITH_READLINE=OFF \
          -DWITH_SSL=system \
          -DPLUGIN_ROCKSDB=NO
  make
}

do_install() {
  make install
  rm -rf "${pkg_prefix}/mysql-test"
  rm -rf "${pkg_prefix}/bin/mysql_client_test"
  rm -rf "${pkg_prefix}/bin/mysql_test"
}
