pkg_name=mariadb
pkg_origin=core
pkg_version=10.1.24
pkg_description="An open source monitoring software for networks and applications"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="https://mariadb.org/"
pkg_license=('GPL-2.0')
pkg_source="http://ftp.hosteurope.de/mirror/archive.mariadb.org//${pkg_name}-${pkg_version}/source/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="b3df99ae5b1ec8cf6cede4cbc4ae3f54ce66464549cba6d56d9ff4d24e4d551e"
pkg_deps=(
  core/gcc-libs
  core/ncurses
  core/zlib
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
    export CXXFLAGS="$CFLAGS"
}

do_build() {
    cmake . -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
            -DCMAKE_PREFIX_PATH="$(pkg_path_for core/ncurses)" \
            -DCMAKE_BUILD_TYPE=Release \
            -DWITH_READLINE=OFF
    make
}

do_install() {
    make install
    rm -rf "${pkg_prefix}/mysql-test"
    rm -rf "${pkg_prefix}/bin/mysql_client_test"
    rm -rf "${pkg_prefix}/bin/mysql_test"
}
