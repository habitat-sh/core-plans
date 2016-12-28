pkg_name=mariadb
pkg_origin=core
pkg_version=10.1.18
pkg_description="An open source monitoring software for networks and applications"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source=http://mirror.lstn.net/${pkg_name}//${pkg_name}-${pkg_version}/source/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=d7336907e9ff44496d6453f92526b25bd253638a64a051ca879f953499873b73
pkg_deps=(core/ncurses core/gcc-libs core/zlib)
pkg_build_deps=(core/gcc core/make core/coreutils core/cmake)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(3306)
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
    cmake . -DCMAKE_INSTALL_PREFIX=${pkg_prefix} \
            -DCMAKE_PREFIX_PATH=$(pkg_path_for core/ncurses) \
            -DCMAKE_BUILD_TYPE=Release \
            -DWITH_READLINE=OFF
    make
}

do_install() {
    make install
    rm -rf ${pkg_prefix}/mysql-test
    rm -rf ${pkg_prefix}/bin/mysql_client_test
    rm -rf ${pkg_prefix}/bin/mysql_test
}