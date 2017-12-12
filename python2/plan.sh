pkg_name=python2
pkg_distname=Python
pkg_version=2.7.14
pkg_origin=core
pkg_license=('Python-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Python is a programming language that lets you work quickly
  and integrate systems more effectively."
pkg_upstream_url=https://www.python.org/
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_source=https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz
pkg_shasum=304c9b202ea6fbd0a4a8e0ad3733715fbd4749f2204a9173a58ec53c32ea73e8
pkg_deps=(
  core/bzip2
  core/gcc-libs
  core/gdbm
  core/glibc
  core/ncurses
  core/openssl
  core/readline
  core/sqlite
  core/zlib
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/gcc
  core/gdb
  core/linux-headers
  core/make
  core/util-linux
)
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
    ./configure --prefix="$pkg_prefix" \
                --enable-shared \
                --enable-unicode=ucs4 \
                --with-ensurepip
    make
}

do_check() {
  make test
}

do_install() {
  do_default_install

  platlib=$(python -c "import sysconfig;print(sysconfig.get_path('platlib'))")
  cat <<EOF > "$platlib/_manylinux.py"
# Disable binary manylinux1(CentOS 5) wheel support
manylinux1_compatible = False
EOF
}
