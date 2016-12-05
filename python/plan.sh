pkg_name=python
pkg_version=3.5.2
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Python-2.0')
pkg_description="Python is a programming language that lets you work quickly \
  and integrate systems more effectively."
pkg_upstream_url="https://www.python.org"
pkg_dirname=Python-${pkg_version}
pkg_source=https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz
pkg_filename=${pkg_dirname}.tgz
pkg_shasum=1524b840e42cf3b909e8f8df67c1724012c7dc7f9d076d4feef2d3eff031e8a0
pkg_deps=(
  core/bzip2
  core/coreutils
  core/gcc-libs
  core/glibc
  core/make
  core/ncurses
  core/openssl
  core/readline
  core/sqlite
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/linux-headers
  core/sqlite
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include Include)
pkg_interpreters=(bin/python bin/python3 bin/python3.5)

do_prepare() {
  sed -i.bak 's/#zlib/zlib/' Modules/Setup.dist
  sed -i -re "/(SSL=|_ssl|-DUSE_SSL|-lssl).*/ s|^#||" Modules/Setup.dist
}

do_build() {
  CPPFLAGS=$CFLAGS
  LDFLAGS="${LDFLAGS} -lgcc_s"
  LD_LIBRARY_PATH=$(pkg_path_for gcc)/lib
  export CPPFLAGS LD_LIBRARY_PATH
  ./configure "--prefix=${pkg_prefix}" \
    --enable-shared
  make
}

do_install() {
  do_default_install

  # link python3.5 to python for pkg_interpreters
  ln -rs "${pkg_prefix}/bin/python3.5" "${pkg_prefix}/bin/python"

  # Upgrade to the latest pip
  "$pkg_prefix/bin/pip3" install --upgrade pip
}

do_check() {
  make test
}
