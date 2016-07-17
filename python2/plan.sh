pkg_name=python2
pkg_version=2.7.12
pkg_origin=core
pkg_license=('Python-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Python is a programming language that lets you work quickly
  and integrate systems more effectively."
pkg_upstream_url=https://www.python.org/
pkg_dirname=Python-${pkg_version}
pkg_source=https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz
pkg_filename=${pkg_dirname}.tgz
pkg_shasum=3cb522d17463dfa69a155ab18cffa399b358c966c0363d6c8b5b3bf1384da4b6
pkg_deps=(core/glibc core/gcc-libs core/coreutils core/make core/ncurses core/zlib core/readline core/openssl core/bzip2 core/sqlite)
pkg_build_deps=(core/linux-headers core/gcc)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include Include)
pkg_interpreters=(bin/python bin/python2 bin/python2.7)

do_prepare() {
    sed -i.bak 's/#zlib/zlib/' Modules/Setup.dist
    sed -i -re "/(SSL=|_ssl|-DUSE_SSL|-lssl).*/ s|^#||" Modules/Setup.dist

    # Allow embedded sqlite to load extensions
    # Uncertain if this is absolutely required, leaving commented for now.
    # https://docs.python.org/2/library/sqlite3.html#f1
    # sed -i 's/sqlite_defines.append(("SQLITE_OMIT_LOAD_EXTENSION", "1"))//g' setup.py
}

do_build() {
    ./configure --prefix="${pkg_prefix}" \
                --enable-shared \
                --with-ensurepip
    make
}

do_check() {
  LD_LIBRARY_PATH=$PWD ./python -E -c 'import sqlite3'
}
